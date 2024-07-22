function find-desktop-file() {
  # run mimeo to find the desktop file for the current desktop
  # then removes the first line and remove the padding of the second line
  # e.g.
  # mimeo --app2desk jellyfinmediaplayer
  # mimeo --finddesk com.github.iwalton3.jellyfin-media-player.desktop
  # mimeo --app2desk /usr/share/applications/com.github.iwalton3.jellyfin-media-player.desktop
  App2Desk="$(mimeo --app2desk $1)"
  # echo "$App2Desk"
  FILE="$(echo "$App2Desk" | tail -n +2 | sed 's/^ *//')"
  # echo "$FILE"

  mimeo --finddesk "$FILE"
}
