#!/bin/zsh

# shared env with xinit
source $HOME/.config/.env

export ZSH_COMPONENT=$ZDOTDIR/components
export ADOTDIR=$XDG_DATA_HOME/zsh/antigen

ZSHZ_DATA="$XDG_DATA_HOME/zsh/z"
HISTFILE="$XDG_DATA_HOME/zsh/history"

source $ZSH_COMPONENT/antigen.zsh
source $ZSH_COMPONENT/zkbd.zsh
source $ZSH_COMPONENT/aliases.zsh
source $ZSH_COMPONENT/utility.zsh
source $ZSH_COMPONENT/bindings.zsh
source $ZSH_COMPONENT/external/bracketed-paste-magic.zsh
source $ZSH_COMPONENT/rustup.zsh

path+=("$HOME/.local/bin")

# host specific settings
file=$ZDOTDIR/host/$(hostname).zsh
if [ -f $file ]; then
    source $file
fi
