#!/usr/bin/env bash

if ! pgrep hyprpaper; then
  echo "hyprpaper is not running yet, starting it"
  hyprpaper &
  sleep 1
fi

echo
echo "Changing wallpaper"

SCRIPT_DIRECTORY="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
echo "Script is located in: $SCRIPT_DIRECTORY"
WALLPAPERS_FILE="$SCRIPT_DIRECTORY/used-wallpapers.txt"
DIRECTORY="$HOME/Pictures/Wallpapers"

while true; do
  # Create the files if they don't exist
  if [ ! -f "$WALLPAPERS_FILE" ]; then
    touch "$WALLPAPERS_FILE"
  fi

  WALLPAPER=$(ls "$DIRECTORY" | shuf -n 1)

  readarray -t USED_WALLPAPERS <"$WALLPAPERS_FILE"

  if [[ ! " ${USED_WALLPAPERS[@]} " =~ " ${WALLPAPER} " ]]; then
    echo "Wallpaper $WALLPAPER is not in the list of used wallpapers, using it"
    break
  fi

  if [ ${#USED_WALLPAPERS[@]} -eq $(ls "$DIRECTORY" | wc -l) ]; then
    echo "All wallpapers have been used, removing the file $WALLPAPERS_FILE"

    rm "$WALLPAPERS_FILE"
  fi
done

echo "$WALLPAPER" >>"$WALLPAPERS_FILE"

FINAL="$DIRECTORY/$WALLPAPER"
echo "Unloading all wallpapers: $(hyprctl hyprpaper unload all)"
echo "Preloading wallpaper: $(hyprctl hyprpaper preload "$FINAL")"
echo "Setting wallpaper on DP-1: $(hyprctl hyprpaper wallpaper "DP-1,$FINAL")"
echo "Setting wallpaper on DP-2: $(hyprctl hyprpaper wallpaper "DP-2,$FINAL")"

echo "Wallpaper successfully changed to $FINAL"
