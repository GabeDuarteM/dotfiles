#!/usr/bin/env bash
set -u

echo
echo "Changing wallpaper"

SCRIPT_DIRECTORY="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
WALLPAPERS_FILE="$SCRIPT_DIRECTORY/used-wallpapers.txt"
DIRECTORY="$HOME/Pictures/Wallpapers"

shopt -s nullglob
WALLPAPERS=()
for path in "$DIRECTORY"/*; do
  [[ -f "$path" ]] && WALLPAPERS+=("$path")
done

if ((${#WALLPAPERS[@]} == 0)); then
  printf 'No wallpapers found in %s\n' "$DIRECTORY" >&2
  exit 1
fi

USED_WALLPAPERS=()
if [[ -f "$WALLPAPERS_FILE" ]]; then
  mapfile -t USED_WALLPAPERS <"$WALLPAPERS_FILE"
fi

UNUSED_WALLPAPERS=()
for wallpaper in "${WALLPAPERS[@]}"; do
  used=false
  for previous in "${USED_WALLPAPERS[@]}"; do
    if [[ "$wallpaper" == "$previous" ]]; then
      used=true
      break
    fi
  done

  if [[ "$used" == false ]]; then
    UNUSED_WALLPAPERS+=("$wallpaper")
  fi
done

if ((${#UNUSED_WALLPAPERS[@]} == 0)); then
  echo "All wallpapers have been used, clearing the history"
  : >"$WALLPAPERS_FILE"
  UNUSED_WALLPAPERS=("${WALLPAPERS[@]}")
fi

FINAL=${UNUSED_WALLPAPERS[RANDOM % ${#UNUSED_WALLPAPERS[@]}]}
printf '%s\n' "$FINAL" >>"$WALLPAPERS_FILE"

caelestia wallpaper -f "$FINAL" --no-smart
caelestia scheme set -m dark

echo "Wallpaper successfully changed to $FINAL"
