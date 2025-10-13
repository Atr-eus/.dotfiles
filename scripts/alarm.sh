#!/usr/bin/env bash

# Usage: ./alarm.sh HH:MM [message]

if [[ -z "$1" ]]; then
    echo "Usage: $0 HH:MM [message]"
    exit 1
fi

tim="$1"
msg="${2:-Wake up!}"

now=$(date +%s)
epoch=$(date -d "$tim" +%s 2>/dev/null)

if (( epoch <= now )); then
    epoch=$(( epoch + 86400 ))
fi

sleep_duration=$(( epoch - now ))

echo "Alarm set for $tim ($sleep_duration seconds from now)"
sleep "$sleep_duration"

if command -v notify-send &>/dev/null; then
    notify-send "Alarm" "$msg"
fi

echo "$msg"
echo "Press Ctrl+C to stop the alarm."

while true; do
    if command -v mpv &>/dev/null; then
        mpv --volume=100 --really-quiet /usr/share/sounds/freedesktop/stereo/alarm-clock-elapsed.oga 2>/dev/null
    elif command -v paplay &>/dev/null; then
        paplay /usr/share/sounds/freedesktop/stereo/alarm-clock-elapsed.oga
    elif command -v play &>/dev/null; then
        play -nq -t alsa synth 2 sine 880
    else
        echo -e "\a"
    fi

    sleep 1
done
