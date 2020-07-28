# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# override aliases defined automatically by prezto
source ~/.aliases.override.sh

# Source all functions
for f in ~/.functions/*; do
   source $f
done

# Source local config, if it exists.
if [[ -s ~/.local/.zshrc.local.zsh ]]; then
  source ~/.local/.zshrc.local.zsh
fi

# Configure fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ******************************************************************
#  Make up and down history search work on kitty+tmux
#  Inspired by https://github.com/zimfw/zimfw/issues/293#issuecomment-422118904
# ******************************************************************
bindkey "^[OA" history-substring-search-up
bindkey "^[OB" history-substring-search-down
bindkey -M vicmd "^[OA" history-substring-search-up
bindkey -M vicmd "^[OB" history-substring-search-down
# Make it also work with j and k on normal mode
bindkey -M vicmd "k" history-substring-search-up
bindkey -M vicmd "j" history-substring-search-down
# open command in vim
bindkey -M vicmd "^V" edit-command-line

# enables vi-mode indication using spaceship
spaceship_vi_mode_enable

# disable autocompletion set by prezto's utility module
unsetopt CORRECT

  # Set Spaceship ZSH as a prompt
  autoload -U promptinit; promptinit
  prompt spaceship

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
