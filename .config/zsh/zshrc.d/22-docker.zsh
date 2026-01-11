if ! hascommand docker; then
	return;
fi

# docker ps with less clutter
alias dockerps="docker ps --format 'table {{.Names}}\t{{.Image}}\t{{.Status}}'"

# docker oneshots
dock() {
	image="${1:-alpine}"
	shift
	docker run --rm -it --net=host "$image" $@
}

if ! hascommand docker-compose; then
	return;
fi

alias dup="docker-compose up -d"
alias dupi="docker-compose up"
alias dupf="docker-compose up -d --force-recreate"
alias ddown="docker-compose down --remove-orphans"
alias dex="docker-compose exec"
alias dlog="docker-compose logs"
alias drun="docker-compose run"
alias dpull="docker-compose pull"
