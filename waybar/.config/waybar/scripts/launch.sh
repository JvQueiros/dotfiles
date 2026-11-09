#!/usr/bin/env bash
# style.css imports the generated theme.css, so it must exist before waybar starts.

"$(dirname "$(realpath "$0")")/bar" theme

pkill -x waybar
setsid -f waybar >/dev/null 2>&1
