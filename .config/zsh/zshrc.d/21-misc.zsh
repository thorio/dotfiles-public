hascommand() {
	command -v $1 > /dev/null
}

cond-alias() {
	if hascommand $1; then
		alias "$2"
	fi
}

# startx with custom config location
# NOTE: overwritten for some hosts
if ! hascommand x; then
	x() {
		startx ~/.config/xinit/xinitrc.sh
	}
fi

# pretty-printed path
show-path() {
	echo $PATH | tr -s ':' '\n'
}

cond-alias zfs zlist="zfs list -o name,mountpoint,used,available,referenced,compression,compressratio"

# find and run the first Makefile up the tree, stopping at ~
make() {
	MF="Makefile"
	CWD=$(pwd)

	while true; do
		if [ -e "$MF" ]; then
			/bin/make $@
			e=$?
			cd "$CWD"
			return $e
		fi

		if [ "$(pwd)" = "$HOME" ] || [ "$(pwd)" = "/" ]; then
			cd "$CWD"
			echo "ERR: no makefile found"
			return 2
		fi

		cd ..
	done
}

# misc
cond-alias zeditor "zed=zeditor"
cond-alias apt "apt=sudo apt"
cond-alias ffmpeg ffmpeg="ffmpeg -hide_banner"
cond-alias ffprobe ffprobe="ffprobe -hide_banner"
cond-alias sudo sudo="sudo "
cond-alias ufw ufw="sudo ufw"
cond-alias grep grep="grep --color=auto"
cond-alias df df="df -x tmpfs -x efivarfs -x devtmpfs -h"
cond-alias lsblk lsblk="lsblk -o name,mountpoints,label,size,uuid"
cond-alias ranger r="source ranger"
cond-alias nemo fm='nemo . 2>/dev/null >/dev/null & disown'
cond-alias yt-dlp ytdl="yt-dlp"
