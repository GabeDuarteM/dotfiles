#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Makes every folder inside "Projects" available when executing "cd"
CDPATH=.:$HOME:$HOME/Projects

source ~/.profile
source ~/.aliases

# enable z
. `which brew | sed 's/bin\/brew/etc\/profile.d\/z.sh/'`

export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git/*"'
export FZF_DEFAULT_OPTS='--preview "[[ $(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -500"'

# ******************************************************************
# reboot directly to windows 
#   Inspired by http://askubuntu.com/questions/18170/how-to-reboot-into-windows-from-ubuntu
# ******************************************************************
function reboot_to_windows {
  WINDOWS_TITLE=`grep -i 'windows' /boot/grub/grub.cfg|cut -d"'" -f2`
  sudo grub-reboot "$WINDOWS_TITLE"
  sudo reboot
}


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
