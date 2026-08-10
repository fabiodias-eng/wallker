# Wallker

Wallker is a simple Linux wallpaper changer that randomly rotates wallpapers at configurable intervals using systemd timers.

## How to install
```bash
git clone https://github.com/fabiodias-eng/wallker.git
cd wallker
bash install.sh
```
## Usage
### Change timer
Wallker follows the systemd timer format.
- s - seconds
- m - minutes
- h - hours
- and so on.
```bash
wallker --timer 30m
```
### Change wallpaper directory
```bash
wallker --dir ~/Pictures/custom_wallpapers
```
## How to uninstall
```bash
bash uninstall.sh
```

## Dependencies
The only dependency is [feh](https://github.com/derf/feh), which is installed automatically by `install.sh`

## Checking status

```bash
systemctl --user status wallker.timer
systemctl --user status wallker.service
systemctl --user list-timers wallker.timer
```
