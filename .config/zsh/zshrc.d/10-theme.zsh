user() {
	if [[ -n $SSH_CONNECTION || -f /.dockerenv ]]; then
		echo "%{$FG[014]%}%n@%m:"
	fi
}

directory() {
	echo "%{$FG[077]%}%~"
}

lambda() {
	echo "%{$fg_bold[green]%}λ"
}

PROMPT='$(user)$(directory) $(git_prompt_info)'
PROMPT+=$'\n'"$(lambda)%{$reset_color%} "

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="*"
