#!/usr/bin/env bash
# Installs fx-autoconfig into Zen.app and copies walkback into Zen's default profile.
# Re-run after a Zen update (which wipes the app-side files) or after editing walkback.
set -euo pipefail

FX_AUTOCONFIG_REF=dfdab5684faffc112b76ccb1d8cab7f75da0102c
APP=/Applications/Zen.app/Contents/Resources
ZEN="$HOME/Library/Application Support/zen"
PROFILE="$ZEN/$(grep -m1 '^Default=Profiles/' "$ZEN/profiles.ini" | cut -d= -f2-)"
HERE="$(cd "$(dirname "$0")" && pwd)"

fetch() {
  curl -fsSL "https://raw.githubusercontent.com/MrOtherGuy/fx-autoconfig/$FX_AUTOCONFIG_REF/$1" -o "$2"
}

mkdir -p "$APP/defaults/pref" "$PROFILE/chrome/utils" "$PROFILE/chrome/JS" "$PROFILE/chrome/CSS"
fetch program/config.js "$APP/config.js"
fetch program/defaults/pref/config-prefs.js "$APP/defaults/pref/config-prefs.js"
for file in boot.sys.mjs chrome.manifest fs.sys.mjs module_loader.mjs uc_api.sys.mjs utils.sys.mjs; do
  fetch "profile/chrome/utils/$file" "$PROFILE/chrome/utils/$file"
done

cp "$HERE/walkback.uc.js" "$PROFILE/chrome/JS/"
cp "$HERE/walkback.uc.css" "$PROFILE/chrome/CSS/"

echo "Installed into $PROFILE"
echo "Now open about:support, click 'Clear startup cache', and let Zen restart."
