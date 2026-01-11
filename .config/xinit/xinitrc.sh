set -e

source ~/.config/.env
source ~/.config/xinit/util.sh

# source script fragments
for file in $(shopt -s nullglob; echo ~/.config/xinit/init.d/*.sh); do
    source $file
done

# host specific settings
host_config=~/.config/xinit/host/$(hostname).sh
if [ -f $host_config ]; then
    source $host_config
fi

exec xmonad
