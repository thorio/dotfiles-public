# exa/ls
alias ls="ls --color=tty"
if hascommand eza; then
	alias l="eza -algM --group-directories-first"
else
	alias l="ls -lAh --group-directories-first"
fi

# used for bat and delta
export BAT_THEME="Visual Studio Dark+"

# bat/cat
if hascommand bat; then
	alias cat='bat -p'
elif hascommand batcat; then
	alias cat='batcat -p'
fi

# interactive history search when not piped
history() {
	if [ -t 1 ] && hascommand fzf; then
		selection=$(omz_history | fzf | sed -E 's/^\s+[0-9]+\s+//')

		if [ -z "$selection" ]; then
			return
		fi

		print -z "$selection"
	else
		omz_history
	fi
}
