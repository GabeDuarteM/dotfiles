#!/bin/bash

function log() {
  GREEN_COLOR='\033[0;32m'
  END_COLOR='\033[m'
  echo
  echo -e "${GREEN_COLOR}###########################################################################"
  echo -e "${GREEN_COLOR}## $1"
  echo -e "${GREEN_COLOR}###########################################################################${END_COLOR}"
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
sudo -v

# Source .profile, so the checks for installed executables works when in bash
source ~/.profile >/dev/null 2>&1

# Make directories
mkdir -p ~/projects
mkdir -p ~/.config/nvim
mkdir -p ~/.local/share/nvim/backup
mkdir -p ~/.local/share/nvim/swap

# Install brew if necessary. May fail when macOS don't have the requirements, 
# I still need to check how to install them.
# https://docs.brew.sh/Installation#macos-requirements
if [[ "$(hasCommand 'brew')" == "false" ]]; then
  log "Install brew"

  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # export PATH=$(brew --prefix)/bin:$(brew --prefix)/sbin:$PATH
fi

log "Install brew bundle"

brew bundle --global

# Add the latest version of node if its not there

if [[ "$(hasCommand 'node')" == "false" ]]; then
    log "Install latest node"

    asdf plugin add nodejs
    asdf install nodejs latest
    asdf global nodejs latest
fi

if [[ "$(hasCommand 'yarn')" == "false" ]]; then
    log "Install yarn"

    curl -o- -L https://yarnpkg.com/install.sh | bash
fi

log "Install yarn packages"
yarn global add neovim @fsouza/prettierd eslint_d typescript tldr typescript-language-server @tailwindcss/language-server

if ! grep "zsh" /etc/shells; then
  log "Add zsh to the shell list"

  command -v zsh | sudo tee -a /etc/shells >/dev/null 2>&1
fi

log "Executing fzf install script"
brew info fzf | grep fzf/install | xargs bash

log "Set zsh as the default shell"
sudo chsh -s "$(command -v zsh)" "${USER}"

log "Setup complete\n## Don't forget to run :PackerSync\n## and :checkhealth on vim to install plugins and check if \n## everything is correctly installed"
