ANTIDOTE_DIR=$XDG_DATA_HOME/zsh/antidote;

# clone antidote if it's missing
if [[ ! -a $ANTIDOTE_DIR ]] then
	git clone --depth=1 https://github.com/mattmc3/antidote.git $ANTIDOTE_DIR
fi

source $ANTIDOTE_DIR/antidote.zsh

antidote load

ZSHZ_KEEP_DIRS=( /mnt /media)
ZSH_AUTOSUGGEST_STRATEGY=(history)
