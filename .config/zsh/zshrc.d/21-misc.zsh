hascommand() {
	command -v $1 > /dev/null
}

if hascommand apt; then
	alias apt="sudo apt"
fi

# startx with custom config location
# NOTE: overwritten for some hosts
x() {
	startx ~/.config/xinit/xinitrc.sh
}

# pretty-printed path
show-path() {
	echo $PATH | tr -s ':' '\n'
}

if hascommand zfs; then
	alias zlist="zfs list -o name,mountpoint,used,available,referenced,compression,compressratio"
fi

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

# ffmpeg
alias ffmpeg="ffmpeg -hide_banner"
alias ffprobe="ffprobe -hide_banner"

# misc
alias sudo="sudo "
alias ufw="sudo ufw"
alias diff="diff --color"
alias grep="grep --color=auto"
alias df="df -x tmpfs -x efivarfs -x devtmpfs -h"
alias lsblk="lsblk -o name,mountpoints,label,size,uuid"
alias r="source ranger"
alias fm='nemo . 2>/dev/null >/dev/null & disown'
alias ytdl="yt-dlp"
