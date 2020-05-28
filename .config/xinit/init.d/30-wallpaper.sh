set_wallpaper() {
    feh --no-fehbg --bg-fill "$@"
}

if [ -d "$HOME/cloud/apps/wallpaper/landscape" ]; then
	set_wallpaper "$(shuf -e -n1 ~/cloud/apps/wallpaper/landscape/*)"
else
	set_wallpaper ~/.config/desktop-default.png
fi
