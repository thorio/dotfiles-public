#!/bin/zsh

# clear all aliases before this point, except for those listed
saved_aliases=$(alias -L n z)
unalias -m '*'
eval $saved_aliases
unset saved_aliases

# docker/compose
alias dup="docker-compose up -d"
alias dupi="docker-compose up"
alias dupf="docker-compose up -d --force-recreate"
alias ddown="docker-compose down --remove-orphans"
alias dex="docker-compose exec"
alias dlog="docker-compose logs"
alias drun="docker-compose run"
alias dpull="docker-compose pull"

# git
git_log_options='--pretty=format:"%Cred%h%Creset %G? %Cgreen%>(22)%cr%C(yellow)%d%Creset %s %C(bold blue)<%an>%Creset"'

alias gs="git status"
alias ga="git add"
alias gr="git reset"
alias gc="git commit"
alias gca="git commit --amend --no-edit"
alias gb="git branch"
alias gch="git checkout"
alias gm="git merge"
alias grb="git rebase"
alias gst="git stash"
alias gl="git log $git_log_options"
alias gp="git pull"
alias gps="git push"
alias gdf="git diff"

# dot
alias dot="git --git-dir='$HOME/.local/share/dotfiles.git' --work-tree='$HOME'"

# (sort of) fixes completions
da() { dot add $@ }
_da() { compdef _path_files da }

alias ds="dot status"
alias dr="dot reset"
alias dc="dot commit"
alias dl="dot log $git_log_options"
alias dst="dot stash"
alias dp="dot pull"
alias dps="dot push"
alias ddf="dot diff"

# exa/ls
alias ls="ls --color=tty"
if command -v eza > /dev/null; then
	alias l="eza -alg --group-directories-first"
	alias ll="eza -ag --group-directories-first"
elif command -v exa > /dev/null; then
	alias l="exa -alg --group-directories-first"
	alias ll="exa -ag --group-directories-first"
else
	alias l="ls -lAh"
	alias ll="ls -Ah"
fi

# used for bat and delta
export BAT_THEME="Visual Studio Dark+"

# bat/cat
if command -v bat > /dev/null; then
	alias cat='bat -p'
elif command -v batcat > /dev/null; then
	alias cat='batcat -p'
fi

if command -v apt > /dev/null; then
	alias apt="sudo apt"
fi

# misc
alias sudo="sudo "
alias ufw="sudo ufw"
alias diff="diff --color"
alias grep="grep --color=auto"
alias r="source ranger"
alias fm='nemo . 2>/dev/null >/dev/null & disown'
alias ytdl="yt-dlp"
