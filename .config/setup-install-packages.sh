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

# if it doesnt have sudo, just execute the command
if ! command -v sudo &>/dev/null; then
  log "Sudo was not found, all commands will be executed without it"
  sudo() {
    "$@"
  }
else
  log "Starting install, asking for sudo password now, so we don't need to specify it later"
  sudo -v
fi

# Source .profile, so the checks for installed executables works when in bash
source ~/.profile >/dev/null 2>&1

# Make directories
mkdir -p ~/projects
mkdir -p ~/.config/nvim
mkdir -p ~/.local/share/nvim/backup
mkdir -p ~/.local/share/nvim/swap

if [[ "$(uname)" == "Linux" ]]; then
  # Check if we need to use apt or dnf
  if [[ "$(hasCommand 'apt')" == "true" ]]; then
    log "Ubuntu detected, running pre-requisites"
    sudo apt update -y
    sudo apt upgrade -y
    sudo apt install -y \
      curl \
      git \
      build-essential \
      unzip \
      thefuck \
      tmux
  elif [[ "$(hasCommand 'dnf')" == "true" ]]; then
    log "Fedora detected, running pre-requisites"
    sudo dnf update -y
    sudo dnf upgrade -y
    sudo dnf group install -y "C Development Tools and Libraries" "Development Tools"
    sudo dnf install -y \
      curl \
      git \
      unzip \
      thefuck \
      tmux
  elif [[ "$(hasCommand 'pacman')" == "true" ]]; then
    log "Arch detected, running pre-requisites"

    if [[ "$(hasCommand 'paru')" == "false" ]]; then
      sudo pacman -S paru
    fi

    paru -Syyu --noconfirm --needed \
      act \
      adw-gtk3 \
      atuin \
      audacity \
      autorestic-bin \
      aylurs-gtk-shell-git \
      base-devel \
      bat \
      bibata-cursor-theme \
      blueman \
      brave-bin \
      btop \
      chatterino2-bin \
      cmake \
      colloid-icon-theme-git \
      cronie \
      curl \
      dex \
      docker docker-compose docker-buildx nvidia-container-toolkit \
      downgrade \
      dtrx \
      eww-git \
      eza \
      fabric \
      fastfetch \
      fd \
      flameshot \
      flatseal \
      font-manager \
      foot \
      fzf \
      gamemode \
      gcc \
      gimp \
      git \
      git-delta \
      github-cli \
      gnome-terminal \
      go \
      google-chrome \
      gparted \
      grimblast-git wl-clipboard slurp jq \
      gwenview qt5-imageformats qt6-imageformats \
      handlr-regex \
      hw-probe \
      hyprland-git hyprpaper-git hyprcursor-git xdg-desktop-portal-hyprland-git hyprlang-git hyprpicker-git hyprutils-git hyprwayland-scanner-git egl-wayland-git \
      inotify-tools \
      kate \
      kvantum-qt5 \
      kwallet kwalletmanager kwallet-pam polkit-kde-agent \
      lazygit \
      localsend-bin \
      lsdesktopf \
      lxrandr wlr-randr arandr \
      maim slop tesseract-data-por tesseract-data-deu tesseract-data-eng tesseract \
      mpv \
      ncdu \
      neovim \
      noise-suppression-for-voice \
      notepadqq \
      nvidia-utils lib32-nvidia-utils libva-nvidia-driver cuda \
      nvtop \
      nwg-look \
      obsidian \
      octopi \
      opentabletdriver \
      osu-lazer-bin \
      pamixer \
      parsec \
      piavpn-bin \
      picom \
      podman \
      polybar \
      progress \
      protonup-qt \
      python-pywal colorz \
      python3 python310 \
      qdirstat \
      qt5-wayland qt6-wayland \
      qt6ct \
      rclone \
      redshift \
      retroarch \
      ripgrep \
      rofi-wayland \
      rofimoji wtype \
      ryujinx-bin \
      sddm \
      sed \
      selectdefaultapplication-fork-git \
      slack-desktop \
      snapper grub-btrfs btrfs-assistant snap-pac snap-pac-grub \
      socat \
      sunshine \
      swaync \
      swww \
      syncthingtray \
      thefuck \
      thunar gvfs gvfs-smb smbclient samba cifs-utils \
      tigervnc \
      tldr \
      tmux \
      tree \
      ttf-geist \
      ttf-geist-mono \
      ttf-hack-nerd \
      unzip \
      update-grub \
      vesktop-bin \
      virt-manager libvirt virt-viewer qemu-common \
      vlc \
      whisper.cpp-cublas blas-openblas \
      wine-staging cabextract \
      wireguard \
      wireguard-tools \
      wlogout \
      wmctrl xorg-xwininfo \
      wootility \
      xclip \
      xcolor \
      xdg-desktop-portal xdg-desktop-portal-gtk \
      xone-dkms xone-dongle-firmware \
      yazi \
      yt-dlp \
      zsh-theme-powerlevel10k-git

  else
    log "Linux was detected, but couldn't find which package manager to use, please install them manually"
  fi
fi

# INSTALLED_BREW=false
#
# if [[ "$(hasCommand 'brew')" == "false" ]]; then
# 	log "Install brew"
#
# 	INSTALLED_BREW=true
#
# 	NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
#
# 	if [[ "$(uname)" == "Linux" ]]; then
# 		eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
# 	else
# 		eval "$(/opt/homebrew/bin/brew shellenv)"
# 	fi
#
# 	if [[ "$(hasCommand 'brew')" == "false" ]]; then
# 		log "There was an error detecting brew, tried to add it to the path, but was not successful."
# 		exit
# 	fi
# fi

# log "Install brew bundle"
# export HOMEBREW_BUNDLE_FILE="$HOME/.config/brew/Brewfile"
# brew bundle

if [ ! -d "$HOME/.local/share/tmux/plugins/tpm" ]; then
  log "Installing tmux TPM"
  git clone https://github.com/tmux-plugins/tpm ~/.local/share/tmux/plugins/tpm
fi

if [[ "$(uname)" != "Linux" ]]; then
  log "Installing mac apps through mas"
  mas install 1470584107 # Dato
fi

if [[ "$(hasCommand 'fnm')" == "false" ]]; then
  log "Install fnm bundle"

  curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell

  export PATH="$HOME/.local/share/fnm:$PATH"
  eval "$(fnm env --use-on-cd)"

  if [[ "$(hasCommand 'fnm')" == "false" ]]; then
    log "There was an error detecting fnm, check if it is installed and inside path."
    exit
  fi

fi

# Add the latest version of node if its not there
if [[ "$(hasCommand 'node')" == "false" ]]; then
  log "Node not detected on the path, trying to install its latest version..."

  if [[ "$(hasCommand 'fnm')" == "false" ]]; then
    log "There was an error detecting fnm, check if it is installed and inside path."
    exit
  fi

  fnm install --latest

  if [[ "$(hasCommand 'node')" == "false" ]]; then
    log "There was an error detecting node after install, tried to add it to the path, but was not successful."
    exit
  fi
fi

if [[ "$(hasCommand 'pnpm')" == "false" ]]; then
  log "Install pnpm"

  curl -fsSL https://get.pnpm.io/install.sh | bash -
  f
  if [[ "$(uname)" == "Linux" ]]; then
    export PNPM_HOME="$HOME/.local/share/pnpm"
  else
    export PNPM_HOME="$HOME/Library/pnpm"
  fi

  case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
  esac
fi

if [[ "$(hasCommand 'pnpm')" == "false" ]]; then
  log "There was an error detecting pnpm, tried to add it to the path, but was not successful."
  exit
fi

log "Install pnpm packages"
pnpm i -g neovim @githubnext/github-copilot-cli

if [[ "$(hasCommand '??')" == "false" ]]; then
  log "There was an error detecting packages installed through pnpm, tried to add it to the path, but was not successful."
fi

if [[ "$(hasCommand 'cargo')" == "false" ]]; then
  log "Install rust"

  curl https://sh.rustup.rs -sSf | sh -s -- -y

  source "$HOME/.cargo/env"

  if [[ "$(hasCommand 'cargo')" == "false" ]]; then
    log "There was an error detecting rust, tried to add it to the path, but was not successful."
    exit
  fi
fi

log "Installing additional fonts"
~/.config/.downloaded-fonts/@install.sh && log "Fonts installed"

if ! grep -q "zsh" /etc/shells; then
  log "Add zsh to the shell list"

  command -v zsh | sudo tee -a /etc/shells >/dev/null 2>&1
fi

# if $SHELL is not zsh, without printing to console
if [[ "$(echo $SHELL)" != "$(command -v zsh)" ]]; then
  log "Set zsh as the default shell"
  sudo chsh -s "$(command -v zsh)" "${USER}"
fi

# log "Installing fonts"
#
# mkdir -p ~/.local/share/fonts
#
# cd ~/.local/share/fonts && {
# 	curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/Hack/Regular/HackNerdFontMono-Regular.ttf
# 	cd -
# }

log "Setup complete\n## Don't forget to run :checkhealth on vim to install plugins and check if \n## everything is correctly installed. \n## Also, run Ctrl+a I on tmux to install plugins"

log "Opening ZSH"

zsh
