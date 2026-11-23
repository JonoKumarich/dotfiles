#!/bin/bash
# Opens the Linear ticket in the clipboard, or prompts for one if the clipboard has none.

extract() { grep -oiE '\b[a-z]+-[0-9]+\b' | head -1 | tr '[:lower:]' '[:upper:]'; }

id=$(pbpaste | extract)
if [ -z "$id" ]; then
  id=$(osascript -e 'text returned of (display dialog "Linear ticket:" default answer "ONION-" with title "Open Linear")' 2>/dev/null | extract)
fi
[ -n "$id" ] && open "https://linear.app/tracksuit/issue/$id/"
