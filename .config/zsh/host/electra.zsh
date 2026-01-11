# really dumb solution for using different x configs depending on attached GPU
x() {
	local conf=~/.local/share/X11/display.conf
	echo "" > $conf

 	read -r -d '' nvidia <<- EOF
Section "Device"
	Identifier "dGPU"
	Driver	"nvidia"
	Option	"TripleBuffer"	"True"
	Option	"MetaModes"	"nvidia-auto-select +0+0 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}"
EndSection
EOF

 	read -r -d '' amdgpu <<- EOF
Section "Device"
	Identifier "iGPU"
	Driver "modesetting"
EndSection
EOF

	ddcutil_set_source() {
		ddcutil --sleep-multiplier 0.1 --noverify --bus 0 setvcp 60 $1
	}

	case $1 in
		auto | "")
			if [ $(lspci -vv -s '01:00.0' | grep -Po '(?<=Kernel driver in use: ).*$') = "nvidia" ]; then
				x full
				return
			else
				x thin
				return
			fi
			;;
		implicit) ;;
		full)
			echo $nvidia >> $conf
			echo $amdgpu >> $conf
			ddcutil_set_source 15 &
			;;
		thin)
			echo $amdgpu >> $conf
			ddcutil_set_source 18 &
			;;
		fat)
			echo $nvidia >> $conf
			ddcutil_set_source 15 &
			;;
		*)
			echo "invalid configuration"
			return
			;;
	esac

	unset amdgpu
	unset nvidia

	startx ~/.config/xinit/xinitrc.sh

	ddcutil_set_source 18 &
	unset ddcutil_set_source
}

# vfio
VFIO_RUN_PATH=~/repos/vfio-run/target/debug/vfio-run
alias v="sudo $VFIO_RUN_PATH"

alias vd='v detach game -g passthrough'
alias va='v attach game -g passthrough'

# misc
alias yt-archive='ytdl --add-metadata --no-overwrites --all-subs --embed-subs --compat-options no-live-chat --write-thumbnail -o "/mnt/media/webarchive/%(uploader)s [%(channel_id)s]/%(title)s [%(id)s].%(ext)s"'
