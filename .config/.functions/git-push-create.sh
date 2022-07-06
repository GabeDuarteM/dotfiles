#!/bin/bash
# Pushes the current branch to the remote repository.
gitPushCreate() {
  git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)
}

alias gpc=gitPushCreate
