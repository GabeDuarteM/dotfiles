#!/bin/bash
ln -f $DOTFILES_FOLDER/files/.aliases ~
ln -f $DOTFILES_FOLDER/files/.gitconfig ~
ln -f $DOTFILES_FOLDER/files/.profile ~
ln -f $DOTFILES_FOLDER/files/.zpreztorc ~
ln -f $DOTFILES_FOLDER/files/.zshrc ~
ln -f $DOTFILES_FOLDER/files/vim/.vimrc ~/.config/nvim/init.vim
ln -f $DOTFILES_FOLDER/files/vim/coc-settings.json ~/.config/nvim
ln -f $DOTFILES_FOLDER/files/vim/spell/en.utf-8.add ~/.config/nvim/spell/en.utf-8.add

