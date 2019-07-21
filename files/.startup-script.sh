if [[ "$OSTYPE" == "linux-gnu" ]]; then
    # Remap Caps lock to esc on tap, and ctrl on hold
    setxkbmap -option 'caps:ctrl_modifier'
    xcape -e 'Caps_Lock=Escape'
fi

