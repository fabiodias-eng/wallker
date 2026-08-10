#!/bin/bash

# Install dependencies
echo "Installing dependencies"
sudo apt install feh -y >/dev/null 2>&1

# Install Wallker
echo "Installing Wallker"
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

WALLKER_PATH="$HOME/.local/bin"
WALLKER_CONFIG="$HOME/.config/wallker"
SYSTEMD_USER_DIR="$HOME/.config/systemd/user"

WALLPAPER_DIR="$WALLKER_CONFIG/wallpapers"
WALLPAPER_TIMER="5m"

# Create directories
mkdir -p "$WALLKER_PATH"
mkdir -p "$WALLKER_CONFIG"
mkdir -p "$SYSTEMD_USER_DIR"

# Install executable
ln -sfn "$SCRIPT_DIR/wallker" "$WALLKER_PATH/wallker" >/dev/null 2>&1

# Install wallpapers
ln -sfn "$SCRIPT_DIR/wallpapers" "$WALLPAPER_DIR" >/dev/null 2>&1

# Create config
cat >"$WALLKER_CONFIG/wallker-config" <<EOF
WALLPAPER_DIR="$WALLPAPER_DIR"
WALLPAPER_TIMER="$WALLPAPER_TIMER"
EOF

# Create service
cat >"$SYSTEMD_USER_DIR/wallker.service" <<EOF
[Unit]
Description=Wallker: Change wallpaper

[Service]
Type=oneshot
ExecStart=%h/.local/bin/wallker
EOF

# Create timer
cat >"$SYSTEMD_USER_DIR/wallker.timer" <<EOF
[Unit]
Description=Wallker: Wallpaper rotation timer

[Timer]
OnBootSec=$WALLPAPER_TIMER
OnUnitActiveSec=$WALLPAPER_TIMER
AccuracySec=1s
Unit=wallker.service

[Install]
WantedBy=timers.target
EOF

# Load systemd units
systemctl --user daemon-reload >/dev/null 2>&1

# Enable and start timer
systemctl --user enable --now wallker.timer >/dev/null 2>&1

# Set initial wallpaper
"$WALLKER_PATH/wallker" >/dev/null 2>&1

echo "DONE"
