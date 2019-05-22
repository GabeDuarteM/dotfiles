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
