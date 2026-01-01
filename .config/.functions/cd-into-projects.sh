_getProjectBase() {
  if [ -z "$1" ]; then
    echo "No projects folder specified"
    return
  fi

  echo "$1"/"$(find "$1" -maxdepth 1 -type d ! -path "$1" -exec basename {} \; | fzf --no-preview --height=40% --header="Select the project:" --reverse --query "$2" --select-1)"
}

_getProject() {
  _getProjectBase "$PROJECTS_FOLDER" "$1"
}

function p() {
  local dir
  dir=$(_getProject "$1")

  if [ "$dir" != "$PROJECTS_FOLDER/" ]; then
    cd "$dir" || return
  fi
}

function pp() {
  local base="$PROJECTS_FOLDER/worktrees"
  local selected

  selected=$(find "$base" -mindepth 2 -maxdepth 2 -type d | sed "s|$base/||" | fzf --no-preview --height=40% --header="Select worktree:" --reverse --query "$1" --select-1)

  if [ -n "$selected" ]; then
    cd "$base/$selected" || return
  fi
}
