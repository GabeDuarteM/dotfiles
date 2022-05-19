_getProjectBase() {
  echo $1/$(find $1 -maxdepth 1 -type d ! -path $1 -exec basename {} \; | fzf --no-preview --height=40% --header="Select the project:" --reverse --query "$2" --select-1)
}

_getProject() {
  _getProjectBase "$PROJECTS_FOLDER" "$1"
}

_getWorkProject() {
  _getProjectBase "$WORK_FOLDER" "$1"
}

unalias p

function p() {
  local dir=$(_getProject $1)
  if [ "$dir" != "$PROJECTS_FOLDER/" ]; then;
    cd $dir
  fi
}

# cd into some folder inside the work projects folder
function wp() {
  local dir=$(_getWorkProject $1)
  if [ "$dir" != "$WORK_FOLDER/" ]; then;
    cd $dir
  fi
}

unset _getProjectBase
unset _getProject
unset _getWorkProject
