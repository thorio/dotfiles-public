## swap f12 and printscreen
xmodmap -e "keycode 107 = F12"
xmodmap -e "keycode 96 = Print"

## touchpad configuration
xinput_set "Touchpad" "Tapping Enabled" 1
xinput_set "Touchpad" "Natural Scrolling Enabled" 1
xinput_set "Touchpad" "Middle Emulation Enabled" 1
