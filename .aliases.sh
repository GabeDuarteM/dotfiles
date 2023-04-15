# git
alias g=git
alias ga="git add --all"
alias gc="git commit"
alias gcm="git commit -m"
alias gst="git status"
alias gl="git log"
alias glo="git log --oneline"
alias gp="git push"
alias gco='git-checkout'
alias gpm="gitPullMain"

# yarn
alias y=yarn
alias ys="yarn run start"
alias yt="yarn run test"
alias yl="yarn run lint"
alias yb="yarn run build"
alias yu="yarn upgrade-interactive --latest"

# npm
alias ni="npm install"
alias nr="npm run"
alias ns="npm run start"
alias nt="npm run test"
alias nl="npm run lint"
alias nb="npm run build"
alias nu="npx npm-check -u"

# docker
alias d=docker
alias dc=docker compose
alias dcl="docker-compose logs --follow --tail=100"
alias dcu="docker-compose up --detach"
alias dcs="docker-compose stop"
alias dcr="docker-compose restart"

# misc
alias proj="cd ~/projects"
alias cls="clear"
alias clr="clear && printf '\e[3J'"
alias l='exa -a --icons'
alias ll='exa -1a --icons'
alias :q="exit"
alias vim="$EDITOR"
alias vi="$EDITOR"
alias e="$EDITOR"
alias opencov="open ./coverage/lcov-report/index.html"
alias salias="alias | grep"
alias config='git --git-dir=$DOTFILES_GIT_DIR --work-tree=$HOME'
alias ce='config ls-files ~ | sed "s/ /\\\\ /" | xargs nvim -c "for i in argv() | bnext | endfor"' # sed to escape espaces in filenames, for loop to avoid the vim error E173: more files to edit
alias nvimc='GIT_DIR=~/.config/.dotfiles GIT_WORK_TREE=$HOME command nvim'
alias lg='lazygit'
alias lgc='lazygit --git-dir=$HOME/.config/.dotfiles/ --work-tree=$HOME'
alias r='run $@'
alias clip="xclip -sel clip"
