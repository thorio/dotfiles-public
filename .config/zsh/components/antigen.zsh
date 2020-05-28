#!/bin/zsh

source $ZSH_COMPONENT/external/antigen.zsh

antigen use oh-my-zsh

antigen bundle $ZDOTDIR/custom themes/custom.zsh-theme --no-local-clone

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle docker-compose
antigen bundle thorio/zsh-n
antigen bundle agkozak/zsh-z
antigen bundle jirutka/zsh-shift-select

antigen apply

ZSH_AUTOSUGGEST_STRATEGY=(history)
bindkey '^ ' autosuggest-accept
