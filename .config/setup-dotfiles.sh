#!/bin/bash

shopt -s expand_aliases

alias config='/usr/bin/git --git-dir=$HOME/.config/.dotfiles/ --work-tree=$HOME'

DOTFILES_PATH=$HOME/.config/.dotfiles

cd $HOME

# if it doesnt have sudo, just execute the command
if ! command -v sudo &>/dev/null; then
	echo "####### Sudo was not found, all commands will be executed without it"
	sudo() {
		"$@"
	}
fi

if [ -d "$DOTFILES_PATH" ]; then
	echo "Dotfiles already exist at $DOTFILES_PATH, pulling instead"

	config pull
else
	# We setup with the https url so that we don't need to have ssh keys setup beforehand.
	# Later we change the remote url to ssh, so that we can push/pull changes without auth.
	git clone --bare https://github.com/GabeDuarteM/dotfiles.git $DOTFILES_PATH

	# Check if the .zshrc file exists, and back it up if it does
	if test -f "$HOME/.zshrc"; then
		# If it exists, move it to .zshrc.bak
		mv "$HOME/.zshrc" "$HOME/.zshrc.bak"

		echo "Backed up $HOME/.zshrc to $HOME/.zshrc.bak"
	fi

	config checkout

	config remote set-url origin git@github.com:GabeDuarteM/dotfiles.git
fi

bash $HOME/.config/setup-install-packages.sh
