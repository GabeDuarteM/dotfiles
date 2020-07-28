#!/bin/bash

function log() {
  GREEN_COLOR='\033[0;32m'
  echo
  echo -e "${GREEN_COLOR}###########################################################################"
  echo -e "${GREEN_COLOR}## $1"
  echo -e "${GREEN_COLOR}###########################################################################"
  echo
}

function hasCommand() {
  if command -v $1 >/dev/null 2>&1; then
    echo true
  else
    echo false
  fi
}

log "Starting install, asking for sudo password"
# Asking for sudo now, so it isn't asked later
sudo echo

# Make the script exit if there's an error
set -e

# Declare variables
PROJECTS_FOLDER=~/Projects

# Source .profile, so the checks for installed executables works when in bash
source ~/.profile >/dev/null 2>&1

# Make directories
mkdir -p $PROJECTS_FOLDER
mkdir -p ~/.config/nvim
mkdir -p ~/.config/nvim/spell
mkdir -p ~/.local/share/nvim/backup
mkdir -p ~/.local/share/nvim/swap

# Install brew if necessary. May fail when macOS don't have the requirements, 
# I still need to check how to install them.
# https://docs.brew.sh/Installation#macos-requirements
if [[ "$(hasCommand 'brew')" == "false" ]]; then
  log "Install brew"

  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  # export PATH=$(brew --prefix)/bin:$(brew --prefix)/sbin:$PATH
fi

log "Install brew bundle"

brew bundle --global

log "Install pip and pip3 packages"
pip install --user pynvim
pip3 install --user powerline-status pynvim

log "Install yarn packages"
yarn global add neovim spaceship-prompt

log "Install gems"
gem install tmuxinator

if [[ "$(hasCommand 'nvm')" == "false" ]]; then
  log "Install nvm"
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
fi

# Add the latest version of node
log "Install latest node and LTS"

nvm install node
nvm install --lts

log "Install Prezto"

if [ ! -d "${ZDOTDIR:-$HOME}/.zprezto" ]; then
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
fi

ln -f -s ~/.zprezto/runcoms/zlogin ~/.zlogin
ln -f -s ~/.zprezto/runcoms/zlogout ~/.zlogout
ln -f -s ~/.zprezto/runcoms/zprofile ~/.zprofile
ln -f -s ~/.zprezto/runcoms/zshenv ~/.zshenv

if ! grep "zsh" /etc/shells; then
  log "Add zsh to the shell list"

  command -v zsh | sudo tee -a /etc/shells >/dev/null 2>&1
fi

log "Executing fzf install script"
brew info fzf | grep fzf/install | xargs bash

log "Set zsh as the default shell"
sudo chsh -s "$(command -v zsh)" "${USER}"

log "Setup complete\n## Don't forget to run :PlugInstall, :UpdateRemotePlugins,\n## and :checkhealth on vim to install plugins and check if \n## everything is correctly installed"
