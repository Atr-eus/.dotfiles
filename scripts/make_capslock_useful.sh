#!/usr/bin/bash

set -e

if ! pacman -Q interception-tools interception-caps2esc &> /dev/null; then
  if command -v pacman &> /dev/null && command -v doas &> /dev/null; then
    printf "Installing 'interception-tools' and 'interception-caps2esc'...\n\n"
  
    doas pacman -S interception-tools interception-caps2esc
  else
    printf "doas and/or pacman not found, exitting..."
    exit 1
  fi
  else
    printf "Required packges are already installed, continuing...\n\n"
fi

printf "Creating system-wide configuration for caps2esc...\n\n"

doas mkdir -p /etc/interception/udevmon.d
doas tee /etc/interception/udevmon.d/caps2esc.yaml > /dev/null <<EOL
- JOB: "intercept -g \$DEVNODE | caps2esc | uinput -d \$DEVNODE"
  DEVICE:
    EVENTS:
      EV_KEY: [KEY_CAPSLOCK, KEY_ESC, KEY_LEFTCTRL, KEY_RIGHTCTRL]
EOL

printf "Setting up systemd override...\n\n"

doas mkdir -p /etc/systemd/system/udevmon.service.d
doas tee /etc/systemd/system/udevmon.service.d/override.conf > /dev/null <<EOL
[Service]
ExecStart=
ExecStart=/usr/bin/udevmon -c /etc/interception/udevmon.d/caps2esc.yaml
EOL

printf "Reloading systemd and starting daemon...\n\n"

doas systemctl daemon-reload
doas systemctl restart udevmon
doas systemctl enable udevmon

printf "All done, exitting...\n\n"
exit 0
