#!/bin/bash

# Uninstall Wallker
echo "Uninstalling Wallker"

WALLKER_PATH="$HOME/.local/bin/wallker"
WALLKER_CONFIG="$HOME/.config/wallker"
SYSTEMD_USER_DIR="$HOME/.config/systemd/user"

# Stop and disable timer
systemctl --user disable --now wallker.timer >/dev/null 2>&1

# Set black wallpaper
BLACK_PIXEL="iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNk+M9QDwADhgGAWjR9awAAAABJRU5ErkJggg=="
echo $BLACK_PIXEL | base64 -d | feh --bg-fill -

# Remove systemd units
rm -f "$SYSTEMD_USER_DIR/wallker.timer"
rm -f "$SYSTEMD_USER_DIR/wallker.service"

systemctl --user daemon-reload >/dev/null 2>&1

# Remove Wallker
rm -f "$WALLKER_PATH"
rm -rf "$WALLKER_CONFIG"

echo "DONE"
