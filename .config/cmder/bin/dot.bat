@echo off
git --git-dir="%USERPROFILE%/.local/share/dotfiles.git" --work-tree="%USERPROFILE%" %*
