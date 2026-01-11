if ! hascommand git; then
	return;
fi

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

dot_dir=$HOME/.local/share/dotfiles.git

if [ ! -d "$dot_dir" ]; then
	return;
fi

# dot
alias dot="git --git-dir='$dot_dir' --work-tree='$HOME'"

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
