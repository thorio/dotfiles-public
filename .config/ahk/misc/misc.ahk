#If

; Meta + W closes active window
#W::WinClose, A

; Ctrl + Alt + E opens new explorer window
^!E::Run, "explorer"

; Ctrl + Alt + T opens new terminal window
^!T::
	EnvGet, userprofile, USERPROFILE
	Run, "alacritty" "--working-directory" "%userprofile%"
Return

; Ctrl + Alt + W opens new browser window
^!W::Run, "C:\Program Files\LibreWolf\librewolf.exe"

; Ctrl + Alt + Q opens new incognito browser window
^!Q::Run, "C:\Program Files\LibreWolf\librewolf.exe" "-private-window"
