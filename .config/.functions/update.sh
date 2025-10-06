#!/bin/env bash

unalias update

function update {
  echo "\nUpdating packages..."
  paru -Sy || return 1

  local upgrades
  echo "\nGetting list of packages to update..."
  upgrades=$(paru -Quq) || return 1

  echo "The full package list is below:"
  echo "$upgrades\n"
  echo "\nThere are $(echo "$upgrades" | wc -l) packages to update."

  if echo "$upgrades" | rg 'nvidia-utils'; then
    echo "\nNVIDIA drivers are scheduled to be updated. Continue? [Y/n]"
    read -r answer

    if [[ "$answer" =~ ^[Nn]$ ]]; then
      return 1
    fi
  fi

  echo "\nUpdating the rest of the packages..."
  paru -Su

  echo "\nUpdating flatpak packages..."
  flatpak update
}
