function nas-mount() {
  if [[ -z "$1" ]]; then
    echo "Please provide a share name"
    return
  fi

  echo "Mounting $1 to /mnt/nas/$1"

  sudo mount -t cifs "//gabenas.local/$1" "/mnt/nas/$1" -o credentials=/home/gabe/.config/smb/nas,username=gabe,uid=$(id -u),gid=$(id -g)
}

function nas-umount() {
  sudo umount /mnt/nas/$1
}
