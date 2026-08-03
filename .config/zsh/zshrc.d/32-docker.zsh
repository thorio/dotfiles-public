if ! hascommand docker; then
	return;
fi

# compose aliases
alias dup="docker compose up -d"
alias dupi="docker compose up"
alias dupf="docker compose up -d --force-recreate"
alias ddown="docker compose down --remove-orphans"
alias dex="docker compose exec"
alias dlog="docker compose logs"
alias drun="docker compose run"
alias dpull="docker compose pull"

# docker ps with less clutter
alias dockerps="docker ps --format 'table {{.Names}}\t{{.Image}}\t{{.Status}}'"

# docker oneshots
dock() {
	docker run --rm -it -v=$XDG_CACHE_HOME/scratch/:/scratch/:rw $@
}

dockx() {
	dock --net=host \
		-v "${XAUTHORITY:-$HOME/.Xauthority}:/tmp/.Xauthority:ro" \
		-v "${XDG_RUNTIME_DIR}/pipewire-0:/tmp/pipewire-0:rw" \
		-e "XAUTHORITY=/tmp/.Xauthority" \
		-e "DISPLAY=$DISPLAY" \
		$@
}
