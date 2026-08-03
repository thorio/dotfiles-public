if hascommand fcitx5; then
	export GTK_IM_MODULE=fcitx
	export QT_IM_MODULE=fcitx
	export XMODIFIERS=@im=fcitx

	# https://github.com/alacritty/alacritty/issues/8907
	# fcitx5 &
fi
