#!/bin/bash

echo 255 > /sys/class/backlight/10-0045/brightness
xrandr --output DSI-1 --rotate inverted
xinput map-to-output "pointer:10-0038 generic ft5x06 (00)" DSI-1
xhost +local:host

feh --no-fehbg --bg-fill /opt/screen/wallpaper.png

sleep infinity
