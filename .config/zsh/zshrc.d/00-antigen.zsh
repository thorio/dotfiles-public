export ADOTDIR=$XDG_DATA_HOME/zsh/antigen

source $ZDOTDIR/external/antigen.zsh

antigen use oh-my-zsh

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
