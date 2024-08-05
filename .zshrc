fastfetch

function addToPath() {
  if [[ -d "$1" && ":$PATH:" != *":$1:"* ]]; then
    export PATH="$1:$PATH"
  fi
}

# Configure fnm (may log stuff if the default path is one with nvmrc)
addToPath "$HOME/.local/share/fnm"
# if the path already contains fnm_multishells anywhere on it, don't add it again
# /run/user/1000/fnm_multishells/1336803_1715787608849/bin
if [[ ":$PATH:" != *"fnm_multishells"* ]]; then
  eval "$(fnm env --use-on-cd)"
fi

### THINGS THAT LOG TO THE CONSOLE NEEDS TO BE ABOVE THIS LINE ###

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

addToPath "$HOME/.local/bin"
addToPath "/home/linuxbrew/.linuxbrew/bin" 
addToPath "/opt/homebrew/bin" 
addToPath "$HOME/go/bin" 
export EDITOR="nvim"
export PROJECTS_FOLDER="$HOME/projects"
export DOTFILES_GIT_DIR="$HOME/.config/.dotfiles/"

# For tauri not to conflict with homebrew
export PKG_CONFIG_PATH=/usr/lib/pkgconfig:/usr/share/pkgconfig:/usr/lib/x86_64-linux-gnu/pkgconfig

# set the default path for the brewfile
export HOMEBREW_BUNDLE_FILE="$HOME/.config/brew/Brewfile"

# Configure brew
# eval "$(brew shellenv)"

if [[ -f /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme ]]; then
   source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
fi

# Configure rust
. "$HOME/.cargo/env"

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

# Fix keybindings
bindkey  "^[[H"     beginning-of-line  # Home
bindkey  "^[[F"     end-of-line        # End
bindkey  "^[[3~"    delete-char        # Delete
bindkey  "^[[3;5~"  kill-word          # Ctrl + Delete
bindkey  "^H"       backward-kill-word # Ctrl + Backspace
bindkey  "^[[1;5C"  forward-word       # Ctrl + Right
bindkey  "^[[1;5D"  backward-word      # Ctrl + Left

# Edit command line in place with the EDITOR when pressing ctrl + v
zle -N edit-command-line-inplace
bindkey -M vicmd "^v" edit-command-line-inplace

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Configure fzf
if [[ -f /usr/share/fzf/key-bindings.zsh ]]; then
  source /usr/share/fzf/key-bindings.zsh
  source /usr/share/fzf/completion.zsh
fi

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

# Make zsh completions case insensitive
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
autoload -Uz compinit && compinit

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# Bun
export BUN_INSTALL="$HOME/.bun"
addToPath "$BUN_INSTALL/bin"

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# deno
export DENO_INSTALL="$HOME/.deno"
addToPath "$DENO_INSTALL/bin"

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true

eval $(thefuck --alias)
eval "$(atuin init zsh)"

# Conda
[ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh

if [ -f "/home/gabe/.config/fabric/fabric-bootstrap.inc" ]; then . "/home/gabe/.config/fabric/fabric-bootstrap.inc"; fi
