# dotfiles

## Setup

1. run `git clone --bare git@github.com:GabrielDuarteM/dotfiles.git $HOME/dotfiles`
1. run `alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'`
1. run `config checkout`
1. run `config config --local status.showUntrackedFiles no`
1. run `~/run_once_install-packages.sh`


## See also

- [Useful commands](Useful%20commands.md)
