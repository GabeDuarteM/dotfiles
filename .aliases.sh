# git
alias git=hub
alias g=git
alias ga="git add --all"
alias gc="git commit"
alias gcm="git commit -m"
alias gs="git stash"
alias gsa="git stash apply"
alias gst="git status"
alias gl="git log"
alias glo="git log --oneline"
alias gp="git push"

# yarn
alias y=yarn
alias ys="yarn run start"
alias yt="yarn run test"
alias yl="yarn run lint"
alias yb="yarn run build"
alias yu="yarn upgrade-interactive --latest"
alias sb="yarn storybook"

# npm
alias ni="npm install"
alias nr="npm run"
alias ns="npm run start"
alias nt="npm run test"
alias nl="npm run lint"
alias nb="npm run build"
alias nu="npx npm-check -u"

# misc
alias proj="cd ~/Projects"
alias cls="clear"
alias l='ls -1A'
alias gd-oss="npx -p yo -p generator-gd-scripts -c 'yo gd-scripts'"
alias :q="exit"
alias vim="$EDITOR"
alias vi="$EDITOR"
alias e.="$EDITOR ."
alias clr="clear && printf '\e[3J'"
alias tx="tmuxinator"
alias tq="tmux switch -t default && tmux kill-session -t code"
alias opencov="open ./coverage/lcov-report/index.html"
alias salias="alias | grep"
alias cm="chezmoi"
alias cma="chezmoi apply"
alias c="tx code"
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
alias ce='config ls-files ~ | sed "s/ /\\\\ /" | xargs nvim -c "for i in argv() | bnext | endfor"' # sed to escape espaces in filenames, for loop to avoid the vim error E173: more files to edit
alias lg='lazygit'
alias lgc='lazygit --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
