#!/bin/env bash

update-hypr() {
  paru -Sy || return 1

  local upgrades
  echo "\nGetting list of packages to update..."
  upgrades=$(paru -Quq) || return 1
  echo "The full package list is below:"
  echo "$upgrades\n"
  echo "\nThere are $(echo "$upgrades" | wc -l) packages to update."

  rebuild="false"

  if echo "$upgrades" | rg 'zen-browser'; then
    echo "\nUpdating zen-browser normally requires you to restart it and it also stops working until you do. Continue with the update? [y/N]"
    read -r answer

    if [[ ! "$answer" =~ ^[Yy]$ ]]; then
      return 1
    fi
  fi

  if echo "$upgrades" | rg 'nvidia-utils'; then
    echo "\nNVIDIA drivers are scheduled to be updated. Continue? [y/N]"
    read -r answer

    if [[ ! "$answer" =~ ^[Yy]$ ]]; then
      return 1
    fi
  fi

  dependantsPackages=()

  # If hyprutils is inside $upgrades
  if echo "$upgrades" | grep 'hyprutils'; then
    echo "\nUpdating hyprutils..."

    paru -S --needed $(echo "$upgrades" | grep 'hyprutils') || return 1

    rebuild="true"
    while read -r pkg; do
      [[ -n "$pkg" ]] && dependantsPackages+=("$pkg")
    done < <(pactree -r hyprutils | sed 's/[├─└│]//g' | awk '{print $1}' | sort | uniq | grep -v "^hyprutils$")

    dependantsPackages+=("${hypr_deps[@]}")
  fi

  if echo "$upgrades" | grep 'aquamarine'; then
    echo "\nUpdating aquamarine..."
    if [[ "$rebuild" == "true" ]]; then
      paru -S --needed --rebuild $(echo "$upgrades" | grep 'aquamarine') || return 1
    else
      paru -S --needed $(echo "$upgrades" | grep 'aquamarine') || return 1
    fi

    rebuild="true"

    while read -r pkg; do
      [[ -n "$pkg" ]] && dependantsPackages+=("$pkg")
    done < <(pactree -r aquamarine-git | sed 's/[├─└│]//g' | awk '{print $1}' | sort | uniq | grep -v "^aquamarine-git$")

    dependantsPackages+=("${aqua_deps[@]}")
  fi

  # if rebuild is true, update all hypr packages with --rebuild
  # if the command fails, retry again.
  if [[ "$rebuild" == "true" ]]; then
    echo "\nThere are $(echo "$dependantsPackages" | wc -l) dependant packages to update. Updating them now..."

    if ! paru -S --rebuild ${dependantsPackages[@]}; then
      echo "\nCommand failed. Retrying..."
      paru -S --rebuild ${dependantsPackages[@]} || return 1
    fi
  fi

  echo "\nUpdating the rest of the packages..."
  paru -Su

  echo "\nUpdating flatpak packages..."
  flatpak update
}
