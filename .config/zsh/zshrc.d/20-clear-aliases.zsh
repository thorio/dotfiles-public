# clear all aliases before this point, except for those listed
saved_aliases=$(alias -L n z)
unalias -m '*'
eval $saved_aliases
unset saved_aliases
