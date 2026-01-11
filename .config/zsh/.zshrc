# shared env with xinit
source $HOME/.config/.env

ZSHZ_DATA="$XDG_DATA_HOME/zsh/z"
HISTFILE="$XDG_DATA_HOME/zsh/history"

path+=("$HOME/.local/bin")

sourceall() {
	for file in "$@"; do
		if [ -f $file ]; then
			source $file
		fi
	done
}

sourceall "$ZDOTDIR"/zshrc.d/*.zsh
