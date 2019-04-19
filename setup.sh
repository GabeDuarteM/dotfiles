sudo echo "Starting install
"

# Source .profile, so the checks for installed executables works when in bash
source ~/.profile >/dev/null 2>&1

# Declare variables
PROJECTS_FOLDER=~/Projects
DOTFILES_FOLDER=$PROJECTS_FOLDER/dotfiles

echo "
  Link configs
"
ln --force $DOTFILES_FOLDER/files/.aliases ~
ln --force $DOTFILES_FOLDER/files/.gitconfig ~
ln --force $DOTFILES_FOLDER/files/.profile ~
ln --force $DOTFILES_FOLDER/files/.zpreztorc ~
ln --force $DOTFILES_FOLDER/files/.zshrc ~

# Install apt packages
if [[ "$OSTYPE" == "linux-gnu" ]]; then
  echo "
  Install apt packages
"
  sudo apt update
  sudo apt-get install build-essential curl file git snapd -y
fi

# Make directories
mkdir -p $PROJECTS_FOLDER

# Clone my dotfiles config if necessary
if [ ! -d "$DOTFILES_FOLDER" ]; then
  echo "
  Clone my dotfiles config
"
  git clone https://github.com/GabrielDuarteM/dotfiles $PROJECTS_FOLDER
fi

# Install brew if necessary. May fail when macos dont have the requirements, 
# I still need to check how to install them.
# https://docs.brew.sh/Installation#macos-requirements
if ! command -v brew >/dev/null 2>&1; then
  echo "
  Install brew
"
  if [[ "$OSTYPE" == "linux-gnu" ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)" < /dev/null
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" < /dev/null
  fi
fi
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

# Installing brew packages
echo "
  Installing brew packages
"
brew install n gcc zsh hub yarn bat

# Add gui programs
if [[ "$OSTYPE" == "linux-gnu" ]]; then
  echo "
  Installing snap packages
"
  sudo snap install code --classic
  sudo snap install slack --classic
  sudo snap install postman spotify discord
elif [[ "$OSTYPE" == "darwin"* ]]; then
  echo "
  Installing cask packages
"
  brew tap caskroom/cask
  brew cask install visual-studio-code google-chrome slack postman spotify steam discord
fi

# Brew does not give correct permissions to n, so the code below does that.
# https://github.com/tj/n/issues/416
sudo mkdir -p /usr/local/n
sudo chown -R $(whoami) /usr/local/n
sudo chown -R $(whoami) /usr/local/bin /usr/local/lib /usr/local/include /usr/local/share

# Add the latest version of node
echo "
  Installing latest node
"
n latest

# Install prezto
echo "
  Installing Prezto
"
if [ ! -d "${ZDOTDIR:-$HOME}/.zprezto" ]; then
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
fi
ln -s ~/.zprezto/runcoms/zlogin ~/.zlogin
ln -s ~/.zprezto/runcoms/zlogout ~/.zlogout
ln -s ~/.zprezto/runcoms/zprofile ~/.zprofile
ln -s ~/.zprezto/runcoms/zshenv ~/.zshenv
# Add zsh to the shells, if it is not already
if ! grep "zsh" /etc/shells; then
    command -v zsh | sudo tee -a /etc/shells >/dev/null 2>&1
fi
# Set zsh as default
sudo chsh -s "$(command -v zsh)" "${USER}"
