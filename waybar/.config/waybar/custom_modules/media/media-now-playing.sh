#!/usr/bin/env bash
# Scrolls long titles itself because zscroll isn't packaged on Arch or Ubuntu.

width=30
gap="   ·   "
offset=0
previous=""

while :; do
  text=$(playerctl metadata --format '{{ title }} - {{ artist }}' 2>/dev/null)

  if [[ "$text" != "$previous" ]]; then
    offset=0
    previous="$text"
  fi

  if (( ${#text} <= width )); then
    echo "$text"
  else
    loop="$text$gap$text"
    echo "${loop:offset:width}"
    offset=$(( (offset + 1) % (${#text} + ${#gap}) ))
  fi

  sleep 0.3
done
