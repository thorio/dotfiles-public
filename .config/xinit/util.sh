hascommand() {
	command -v $1 &> /dev/null
}

xinput_set() {
	device_id=$(xinput list | grep "$1" | grep -Po '(?<=id=)\d+')
	prop_id=$(xinput list-props $device_id | grep -v "Default" | grep "$2" | grep -Po '(?<=\()\d+(?=\))')
	xinput set-prop $device_id $prop_id $3
}
