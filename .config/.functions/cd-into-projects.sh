typeset -g _PROJECT_RECENCY_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/project-recency"

_trackProjectVisit() {
  if [[ -z "$PROJECTS_FOLDER" || "$PWD" != "$PROJECTS_FOLDER"/* ]]; then
    return
  fi

  local relative="${PWD#"$PROJECTS_FOLDER"/}"
  local project="${relative%%/*}"

  if [[ -z "$project" || ! -d "$PROJECTS_FOLDER/$project" ]]; then
    return
  fi

  mkdir -p -- "$_PROJECT_RECENCY_DIR" || return
  printf '%s\n' "$(date +%s)" >| "$_PROJECT_RECENCY_DIR/$project"
}

_listProjectsByRecency() {
  local base="$1"
  local dir name timestamp visited modified

  while IFS= read -r -d '' dir; do
    name="${dir##*/}"
    visited=0

    if [[ -r "$_PROJECT_RECENCY_DIR/$name" ]]; then
      IFS= read -r visited < "$_PROJECT_RECENCY_DIR/$name"
      [[ "$visited" == <-> ]] || visited=0
    fi

    # Bypass zsh/stat's `stat` builtin, which does not support GNU `stat -c`.
    modified=$(/usr/bin/stat -c %Y -- "$dir") || modified=0
    ((visited > modified)) && timestamp=$visited || timestamp=$modified
    printf '%s\t%s\n' "$timestamp" "$name"
  done < <(find "$base" -mindepth 1 -maxdepth 1 -type d -print0)
}

_getProjectBase() {
  if [ -z "$1" ]; then
    echo "No projects folder specified" >&2
    return 1
  fi

  local selected
  selected=$(
    _listProjectsByRecency "$1" |
      sort -t $'\t' -k1,1nr -k2,2f |
      cut -f2- |
      fzf --no-preview --no-sort --height=40% --header="Select the project (most recent first):" --reverse --query "$2" --select-1
  )

  [[ -n "$selected" ]] && printf '%s/%s\n' "$1" "$selected"
}

_getProject() {
  _getProjectBase "$PROJECTS_FOLDER" "$1"
}

function p() {
  local dir
  dir=$(_getProject "$1")

  if [[ -n "$dir" ]]; then
    cd "$dir" || return
  fi
}

# Record direct `cd` visits too, not only directories selected through `p`.
autoload -Uz add-zsh-hook
add-zsh-hook -d chpwd _trackProjectVisit 2>/dev/null
add-zsh-hook chpwd _trackProjectVisit
_trackProjectVisit

function pp() {
  local base="$PROJECTS_FOLDER/worktrees"
  local selected

  selected=$(find "$base" -mindepth 2 -maxdepth 2 -type d | sed "s|$base/||" | fzf --no-preview --height=40% --header="Select worktree:" --reverse --query "$1" --select-1)

  if [ -n "$selected" ]; then
    cd "$base/$selected" || return
  fi
}
