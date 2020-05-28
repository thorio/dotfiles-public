#!/usr/bin/env bash

green=$(printf "\e[32m")
yellow=$(printf "\e[33m")
normal=$(printf "\e[0m")

PAGER="${PAGER:=less}"

# don't ask
grep -P '^\s+-- [\w\s]+$|\(".*--.*' ~/.config/xmonad/Custom/Bindings.hs \
	| sed -r 's/^\s*//g' \
	| sed -r 's/^-- (.*)/'$green'\1'$normal'/g' \
	| sed -r 's/^\("([^"]+)",.*-- (.*)$/  '$yellow'\1'$normal'  \2/g' \
	| $PAGER
