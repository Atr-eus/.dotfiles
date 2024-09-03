#!/usr/bin/env python3

import click

import psutil
import pickle
import datetime
import os.path


CONTEXT_SETTINGS = dict(help_option_names=["-h", "--help"])

TEMP_FILE_PATH = "/tmp/network_traffic_last_state"

BYTES_IN_KILOBYTE = 1000
BYTES_IN_MEGABYTE = 1000 * 1000
BYTES_IN_GIGABYTE = 1000 * 1000 * 1000


def _round(bytes_per_sec: float):
    """
    Rounds a given value to be as short as possible
    """

    import math

    decimal_places = 1
    unit = " B/s"
    unit_factor = 1

    if bytes_per_sec >= BYTES_IN_KILOBYTE / 10:
        decimal_places = 1
        unit_factor = 1 / BYTES_IN_KILOBYTE
        unit = "KB/s"

    if bytes_per_sec >= BYTES_IN_MEGABYTE:
        decimal_places = 1
        unit_factor = 1 / BYTES_IN_MEGABYTE
        unit = "MB/s"

    if bytes_per_sec >= BYTES_IN_GIGABYTE:
        decimal_places = 1
        unit_factor = 1 / BYTES_IN_GIGABYTE
        unit = "GB/s"

    # round values appropriately
    if decimal_places > 0:
        rounding_factor = 10 * decimal_places
    else:
        rounding_factor = 1

    bytes_per_sec = bytes_per_sec * rounding_factor
    bytes_per_sec = math.floor(bytes_per_sec)
    bytes_per_sec = bytes_per_sec / rounding_factor

    value = bytes_per_sec * unit_factor
    if value >= 100:
        prefix = ""
    elif 10 <= value < 100:
        prefix = " "
    else:
        prefix = "  "

    return ("%s{0:.%sf}%s" % (prefix, decimal_places, unit)).format(value)


def _get_stats(
    last_state: dict, current_state: dict, interface: str or None, field: str
):
    """
    Compares two states and calculates the bytes/sec rate for a given interface and statistics field.

    :param last_state: the last network statistics state
    :param current_state: the current network statistics state
    :param interface: the interface to measure, if left empty all existing interfaces will be combined
    :param field: the field to measured, f.ex. "bytes_recv"
    """

    value_diff = 0
    if interface is None:
        for interface, stats in last_state.items():
            if interface == "timestamp":
                # ignore our own artificial timestamp interface
                continue

            if interface not in current_state:
                # ignore this interface
                # as we don't have any data to compate it with
                continue

            if field not in stats._fields:
                # ignore this interface as it doesn't have the field
                # we are looking for
                continue

            # sum up all diffs for the specified field
            value_diff += getattr(current_state[interface], field) - getattr(
                stats, field
            )
    else:
        value_diff = getattr(current_state[interface], field) - getattr(
            last_state[interface], field
        )

    time_diff = current_state["timestamp"] - last_state["timestamp"]
    time_diff_in_seconds = time_diff.total_seconds()

    # normalize to bytes/second
    value_per_seconds = value_diff / time_diff_in_seconds

    return value_per_seconds


def _state_contains_interface(state: dict, interface: str):
    return interface in state.keys()


def _state_contains_field(
    state: dict, field: str, interface: str or None = None
) -> bool:
    for current_interface, stats in state.items():
        if current_interface == "timestamp":
            continue

        if interface is not None and current_interface != interface:
            continue

        if field in stats._fields:
            return True

    return False


def _replace_placeholders(
    last_state: dict,
    current_state: dict,
    interface: str or None,
    string_with_placeholders: str,
) -> str:
    import re

    # prepare result
    result = string_with_placeholders

    # find out what placeholders need to be replaced
    placeholders_to_replace = re.findall("%[\\w]+%", string_with_placeholders)

    for p in placeholders_to_replace:
        # strip away percentage symbols
        field_name = p[1:-1]

        if not _state_contains_field(
            last_state, field_name, interface
        ) or not _state_contains_field(current_state, field_name, interface):
            # the specified value could not be found in the
            # statistics data, so we just ignore it
            continue

        replacement_value = _get_stats(last_state, current_state, interface, field_name)
        replacement_value = _round(replacement_value)
        result = result.replace(p, str(replacement_value))

    return result


@click.command(context_settings=CONTEXT_SETTINGS)
@click.option(
    "-f",
    "--format",
    required=False,
    type=str,
    default="Up: %bytes_sent% Down: %bytes_recv%",
    help="The output format of the result including placeholders.",
)
@click.option(
    "-i", "--interface", required=False, type=str, help="The interface to query."
)
def network_traffic(format: str, interface: str):
    """
    Outputs the current network traffic rate for a specific network interface (or all if None is specified)
    """

    # retrieve last value from some kinda persistent place (memory?)
    last_state = None
    if os.path.exists(TEMP_FILE_PATH) and os.path.isfile(TEMP_FILE_PATH):
        with open(TEMP_FILE_PATH, "rb") as file:
            last_state = pickle.load(file)

    # get current value
    current_state = psutil.net_io_counters(pernic=True)
    # add a timestamp to the measured values
    current_state["timestamp"] = datetime.datetime.now()

    # if there was is a previous value, calculate difference for result
    if last_state is not None:
        if interface is not None and not _state_contains_interface(
            current_state, interface
        ):
            click.secho("Interface '%s' not found" % interface, err=True, fg="red")
            exit(1)

        result = _replace_placeholders(last_state, current_state, interface, format)
        click.echo("%s" % (result))
    else:
        click.echo("Waiting for data...")

    # save it for later use
    with open(TEMP_FILE_PATH, "wb") as file:
        pickle.dump(current_state, file)


if __name__ == "__main__":
    network_traffic()
