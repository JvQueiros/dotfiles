#!/usr/bin/env bash
# style.css imports the generated theme.css and config.jsonc includes the generated
# workspaces.jsonc, so both must exist before waybar starts.

bar="$(dirname "$(realpath "$0")")/bar"
"$bar" theme
"$bar" workspaces

pkill -x waybar
setsid -f waybar >/dev/null 2>&1
