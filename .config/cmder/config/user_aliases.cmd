;= @echo off
;= rem Call DOSKEY and use this file as the macrofile
;= %SystemRoot%\system32\doskey /listsize=1000 /macrofile=%0%
;= rem In batch mode, jump to the end of the file
;= goto:eof
;= Add aliases below here

;= rem cmder defaults
fm=explorer .
pwd=cd
clear=cls
unalias=alias /d $1
vi=vim $*

;= rem git
gs=git status $*
ga=git add $*
gr=git reset $*
gc=git commit $*
gca=git commit --amend --no-edit $*
gb=git branch $*
gch=git checkout $*
gm=git merge $*
grb=git rebase $*
gst=git stash $*
gl=git log --pretty=format:"%Cred%h%Creset %G? %Cgreen%>(22)%cr%C(yellow)%d%Creset %s %C(bold blue)<%an>%Creset" $*
gp=git pull $*
gps=git push $*
gdf=git diff $*

;= rem dot
;= rem dot in bin
ds=dot status $*
da=dot add $*
dr=dot reset $*
dc=dot commit $*
dl=dot log --pretty=format:"%Cred%h%Creset %G? %Cgreen%>(22)%cr%C(yellow)%d%Creset %s %C(bold blue)<%an>%Creset" $*
dp=dot pull $*
dps=dot push $*
ddf=dot diff $*

;= rem misc
cat=bat -p --theme "Visual Studio Dark+" $*
sudo=gsudo $*
ls=ls --color=auto $*
l=eza -alg --group-directories-first $*
npp=start "" "%PROGRAMFILES%\Notepad++\notepad++.exe" $*
path=echo %PATH% | tr -s ';' '\n'

;= rem utility
ssh-add-key=cat %USERPROFILE%/.ssh/id_rsa.pub | ssh $1 "cat >> ~/.ssh/authorized_keys"
wsl-forward-port=gsudo netsh interface portproxy add v4tov4 listenport=$1 listenaddress=0.0.0.0 connectport=$2 connectaddress=$1
