#!/bin/env bash

getWindowClass() {
  # Get the position of the cursor
  local cursor_pos=$(hyprctl cursorpos -j)
  local x=$(echo $cursor_pos | jq '.x')
  local y=$(echo $cursor_pos | jq '.y')

  # Get current workspace ID
  local current_workspace=$(hyprctl activewindow -j | jq '.workspace.id')

  # Get all windows and find the one under the cursor
  # Only consider windows that are:
  # 1. On the current workspace
  # 2. Actually visible (not minimized)
  # 3. Under the cursor position
  local window_at_pos=$(hyprctl clients -j | jq -r ".[] | 
        select(.workspace.id == $current_workspace and
               .hidden == false and
               .at[0] <= $x and 
               .at[0] + .size[0] >= $x and 
               .at[1] <= $y and 
               .at[1] + .size[1] >= $y
        ).class" | head -n 1)

  # If no window is found, use 'unknown' as fallback
  echo "${window_at_pos:-unknown}"
}

grimblast --freeze save area - | satty -f - --output-filename ~/Pictures/Screenshots/"$(date '+%Y-%m-%d_%H-%M-%S')-$(getWindowClass).png"
