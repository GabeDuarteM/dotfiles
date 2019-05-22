#!/bin/bash

# Asking for sudo now, so it isn't asked later
sudo echo

function log() {
  GREEN_COLOR='\033[0;32m'
  echo
  echo -e "${GREEN_COLOR}###########################################################################"
  echo -e "${GREEN_COLOR}## $1"
  echo -e "${GREEN_COLOR}###########################################################################"
  echo
}

log "Starting install"

# Make the script exit if there's an error
set -e

# Declare variables
PROJECTS_FOLDER=~/Projects
DOTFILES_FOLDER=$PROJECTS_FOLDER/dotfiles
SKIP_GUI='false'

# -g flag skips the installation of the gui programs, so that it can run on docker
while getopts 'g' flag; do
  case "${flag}" in
    g) SKIP_GUI='true' ;;
  esac
done

# Source .profile, so the checks for installed executables works when in bash
source ~/.profile >/dev/null 2>&1

if [[ "$OSTYPE" == "linux-gnu" ]]; then
  log "Install apt packages"

  sudo apt update
  sudo apt-get install build-essential curl file git snapd -y
fi

# Make directories
mkdir -p $PROJECTS_FOLDER
mkdir -p ~/.config/nvim
mkdir -p ~/.local/share/nvim/backup
mkdir -p ~/.local/share/nvim/swap

# Clone my dotfiles config if necessary
if [ ! -d "$DOTFILES_FOLDER" ]; then
  log "Clone the dotfiles config"

  git clone https://github.com/GabrielDuarteM/dotfiles $DOTFILES_FOLDER
fi

log "Link configs"

ln --force $DOTFILES_FOLDER/files/.aliases ~
ln --force $DOTFILES_FOLDER/files/.gitconfig ~
ln --force $DOTFILES_FOLDER/files/.profile ~
ln --force $DOTFILES_FOLDER/files/.zpreztorc ~
ln --force $DOTFILES_FOLDER/files/.zshrc ~
ln --force $DOTFILES_FOLDER/files/vim/.vimrc ~/.config/nvim/init.vim
ln --force $DOTFILES_FOLDER/files/vim/coc-settings.json ~/.config/nvim

# Install brew if necessary. May fail when macos dont have the requirements, 
# I still need to check how to install them.
# https://docs.brew.sh/Installation#macos-requirements
if ! command -v brew >/dev/null 2>&1; then
  log "Install brew"

  if [[ "$OSTYPE" == "linux-gnu" ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)" < /dev/null
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" < /dev/null
  fi
fi
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

log "Install brew packages"

brew install n gcc zsh hub yarn bat neovim python3 python ripgrep tldr htop z fzf

log "Install pip and pip3 packages"
pip install --user pynvim
pip3 install --user powerline-status pynvim

log "Install yarn packages"
yarn global add neovim

# Add gui programs
if [[ "$SKIP_GUI" == "false" ]]; then
  if [[ "$OSTYPE" == "linux-gnu" ]]; then
    log "Install snap packages"

    sudo snap install code --classic
    sudo snap install slack --classic
    sudo snap install postman spotify discord
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    log "Install cask packages"

    brew tap caskroom/cask
    brew cask install visual-studio-code google-chrome slack postman spotify steam discord
  fi
fi

# Brew does not give correct permissions to n, so the code below does that.
# https://github.com/tj/n/issues/416
sudo mkdir -p /usr/local/n
sudo chown -R $(whoami) /usr/local/n
sudo chown -R $(whoami) /usr/local/bin /usr/local/lib /usr/local/include /usr/local/share

# Add the latest version of node
log "Install latest node"

n latest

log "Install Prezto"

if [ ! -d "${ZDOTDIR:-$HOME}/.zprezto" ]; then
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
fi

ln -s ~/.zprezto/runcoms/zlogin ~/.zlogin
ln -s ~/.zprezto/runcoms/zlogout ~/.zlogout
ln -s ~/.zprezto/runcoms/zprofile ~/.zprofile
ln -s ~/.zprezto/runcoms/zshenv ~/.zshenv

if ! grep "zsh" /etc/shells; then
  log "Add zsh to the shell list"

  command -v zsh | sudo tee -a /etc/shells >/dev/null 2>&1
fi

log "Set zsh as the default shell"
sudo chsh -s "$(command -v zsh)" "${USER}"

log "Setup complete\n## Don't forget to run :PlugInstall, :UpdateRemotePlugins,\n## and :checkhealth on vim to install plugins and check if \n## everything is correctly installed"
