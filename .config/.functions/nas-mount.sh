function nas-mount() {
  if [[ -z "$1" ]]; then
    echo "Please provide a share name"
    exit 1
  fi

  echo "Mounting $1 to /mnt/nas"

  sudo mount -t cifs //gabenas.local/$1 /mnt/nas -o credentials=/home/gabe/.config/smb/nas,username=gabe,uid=$(id -u),gid=$(id -g)
}

function nas-umount() {
  echo sudo umount /mnt/nas
}
