#!/usr/bin/env bash

echo
echo "Changing wallpaper"

SCRIPT_DIRECTORY="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
WALLPAPERS_FILE="$SCRIPT_DIRECTORY/used-wallpapers.txt"
DIRECTORY="$HOME/Pictures/Wallpapers"

while true; do
  if [ ! -f "$WALLPAPERS_FILE" ]; then
    touch "$WALLPAPERS_FILE"
  fi

  WALLPAPER=$(ls "$DIRECTORY" | shuf -n 1)

  readarray -t USED_WALLPAPERS <"$WALLPAPERS_FILE"

  if [[ ! " ${USED_WALLPAPERS[*]} " =~ " ${WALLPAPER} " ]]; then
    echo "Wallpaper $WALLPAPER is not in the list of used wallpapers, using it"
    break
  fi

  if [ ${#USED_WALLPAPERS[@]} -eq $(ls "$DIRECTORY" | wc -l) ]; then
    echo "All wallpapers have been used, clearing the list"
    rm "$WALLPAPERS_FILE"
  fi
done

echo "$WALLPAPER" >>"$WALLPAPERS_FILE"

FINAL="$DIRECTORY/$WALLPAPER"

caelestia wallpaper -f "$FINAL" --no-smart
caelestia scheme set -m dark

echo "Wallpaper successfully changed to $FINAL"
