#!/bin/bash

# Asking for sudo now, so it isn't asked later
sudo echo

git clone --bare git@github.com:GabrielDuarteM/dotfiles.git $HOME/.config/.dotfiles

alias config='/usr/bin/git --git-dir=$HOME/.config/.dotfiles --work-tree=$HOME'

cd ~

config checkout
config config --local status.showUntrackedFiles no

bash ./setup-install-packages.sh
