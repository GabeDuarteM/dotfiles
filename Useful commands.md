# Useful commands

- Set mouse sensitivity

```bash
xinput --set-prop "Logitech Gaming Mouse G502" "Device Accel Constant Deceleration" 1.5
```

- Set keyboard delay/repeats

```bash
xset r rate 200 50
```

- Set screen position

```bash
xrandr --output DP-2 --mode 1920x1080 --rate 144.00 --pos 0x180 --output DP-4 --mode 2560x1440 --rate 144.00 --pos 1920x0 --primary
```

- Fix cedilla on linux: https://github.com/marcopaganini/gnome-cedilla-fix

```bash
wget -q https://raw.githubusercontent.com/marcopaganini/gnome-cedilla-fix/master/fix-cedilla -O fix-cedilla
chmod 755 fix-cedilla
./fix-cedilla
```
