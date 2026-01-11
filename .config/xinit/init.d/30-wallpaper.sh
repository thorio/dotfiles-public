set_wallpaper() {
    feh --no-fehbg --bg-fill "$@"
}

if [ -d "$HOME/cloud/apps/wallpaper/16:9" ]; then
	set_wallpaper "$(shuf -e -n1 ~/cloud/apps/wallpaper/16:9/*)"
else
	set_wallpaper ~/.config/desktop-default.png
fi
