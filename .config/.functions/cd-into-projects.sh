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
