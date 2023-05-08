# Useful commands

- Set mouse sensitivity

```bash
xinput --set-prop "Logitech Gaming Mouse G502" "Device Accel Constant Deceleration" 1.5
```

- Set keyboard delay/repeats

```bash
xset r rate 300 25
```

- Fix cedilla on linux: https://github.com/marcopaganini/gnome-cedilla-fix

```bash
wget -q https://raw.githubusercontent.com/marcopaganini/gnome-cedilla-fix/master/fix-cedilla -O fix-cedilla
chmod 755 fix-cedilla
./fix-cedilla
```
