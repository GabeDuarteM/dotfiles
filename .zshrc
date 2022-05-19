# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$HOME/.bin:$PATH"
export EDITOR="nvim"

# Configure brew
eval "$(brew shellenv)"

source "$(brew --prefix powerlevel10k)/powerlevel10k.zsh-theme"

# Configure ASDF
. "$(brew --prefix asdf)/libexec/asdf.sh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Configure fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Source all functions
if [[ -s ~/.config/.functions ]]; then
  for f in ~/.config/.functions/*; do
     source $f
  done
fi

# Source local config, if it exists.
if [[ -s ~/.zshrc.local.zsh ]]; then
  source ~/.zshrc.local.zsh
fi

source .aliases.sh

# Configure fuck
eval $(thefuck --alias)
