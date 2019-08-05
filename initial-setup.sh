cd ~
curl -sfL https://git.io/chezmoi | sh

~/bin/chezmoi init https://github.com/GabrielDuarteM/dotfiles.git
~/bin/chezmoi apply
