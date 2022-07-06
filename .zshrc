# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH="$HOME/.bin:$PATH"
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export EDITOR="nvim"
export PROJECTS_FOLDER="$HOME/projects"

# Configure brew
eval "$(brew shellenv)"

source "$(brew --prefix powerlevel10k)/powerlevel10k.zsh-theme"

# Configure ASDF
. "$(brew --prefix asdf)/libexec/asdf.sh"

# Add yarn after ASDF, so that it takes priority on the path (for global node binaries)
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Config history
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
[ "$HISTSIZE" -lt 50000 ] && HISTSIZE=50000
[ "$SAVEHIST" -lt 10000 ] && SAVEHIST=10000
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data

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

source ~/.aliases.sh

# Configure fuck
eval $(thefuck --alias)
