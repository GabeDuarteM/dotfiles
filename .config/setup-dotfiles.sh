#!/bin/bash

git clone --bare git@github.com:GabrielDuarteM/dotfiles.git $HOME/.config/.dotfiles

alias config='/usr/bin/git --git-dir=$HOME/.config/.dotfiles --work-tree=$HOME'

cd $HOME

# Check if the .zshrc file exists, and back it up if it does
if test -f "$HOME/.zshrc"; then
  # If it exists, move it to .zshrc.bak
  mv "$HOME/.zshrc" "$HOME/.zshrc.bak"

  echo "Backed up $HOME/.zshrc to $HOME/.zshrc.bak"
fi

config checkout
config config --local status.showUntrackedFiles no

bash $HOME/.config/setup-install-packages.sh
