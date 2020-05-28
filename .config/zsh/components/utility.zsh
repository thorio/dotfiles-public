#!/bin/zsh

hascommand() {
	command -v $1 > /dev/null
}

# add ~/.ssh/id_rsa.pub to a remote machine
ssh-add-key() {
	cat ~/.ssh/id_rsa.pub | ssh $1 "cat >> ~/.ssh/authorized_keys"
}

# run df, but don't show tmpfs and the like
disk() {
	df -h $@ | grep -vP '^(tmpfs|udev|none|tools|/dev/loop\d+)|/usr/lib/wsl/(drivers|lib)'
}

# startx with custom config location
# NOTE: overwritten for some hosts
x() {
	startx ~/.config/xinit/xinitrc.sh
}

# docker ps with less clutter
alias dockerps="docker ps --format 'table {{.Names}}\t{{.Image}}\t{{.Status}}'"

# docker oneshots
dock() {
	image="${1:-alpine}"
	shift
	docker run --rm -it --net=host "$image" $@
}

# pretty-printed path
path() {
	echo $PATH | tr -s ':' '\n'
}

if [ -t 1 ] && hascommand fzf; then
	history() {
		selection=$(omz_history | fzf | sed -E 's/^\s+[0-9]+\s+//')

		if [ -z "$selection" ]; then
			return
		fi

		print -z "$selection"
	}
else
	alias history='omz_history'
fi

if hascommand pacman; then
	lspkg() {
		pacman -Qeq
	}
elif hascommand apt; then
	lspkg() {
		apt list --installed | sed 's/\/.*$//'
	}
fi

if hascommand lspkg; then
	pkgdiff() {
		diff ~/.config/packages.txt <(lspkg)
	}

	pkgdiff-commit() {
		lspkg > ~/.config/packages.txt
	}
fi

# update all package managers etc.
sysupgrade() {
	if hascommand aura; then
		aura -Syu
		aura -Au
	elif hascommand pacman; then
		pacman -Syu
	fi
	if hascommand apt; then
		apt update && apt list --upgradeable && apt upgrade --autoremove
	fi
	if hascommand xmonad; then
		xmonad --recompile
	fi
	if hascommand flatpak; then
		flatpak update && flatpak remove --unused
	fi
	if hascommand dot; then
		dot pull
	fi
	if hascommand rolr; then
		rolr update
	fi
	if hascommand blent; then
		blent update -ap
	fi
}

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
