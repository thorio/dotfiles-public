; emulates the named scratchpad behaviour from xmonad
#If

Scratchpad_Action(identifier, command, position) {
	; if the scratchpad is not running, start it
	If !WinExist(identifier) {
		Scratchpad_Start(identifier, command, position)
		Return
	}

	; if the scratchpad is active, hide it and activate to the window under the cursor
	If WinActive(identifier) {
		Scratchpad_Hide(identifier)
		Return
	}

	; otherwise the scratchpad is hidden and/or inactive, so show and activate it
	Scratchpad_Show(identifier)
}

Scratchpad_Start(identifier, command, position) {
	; run the command and wait for the window to show up
	Run, %command%
	WinWait, %identifier%

	; windows weirdness: window might not realize when it was resized right after launching.
	; fix => wait a while and resize again
	WinMove, %identifier%,, % position[1], % position[2], % position[3], % position[4] - 20
	Sleep, 100
	WinMove, %identifier%,, % position[1], % position[2], % position[3], % position[4]
}

Scratchpad_Hide(identifier) {
	WinHide, %identifier%
	MouseGetPos,,, WinUMID
	WinActivate, ahk_id %WinUMID%
}

Scratchpad_Show(identifier) {
	; hide, then show => moves it to the current workspace
	If WinVisible(identifier) {
		WinHide, %identifier%
		Sleep, 100
	}

	WinShow, %identifier%
	WinActivate, %identifier%
}

; https://www.autohotkey.com/board/topic/1555-determine-if-a-window-is-visible/?p=545045
WinVisible(WinTitle)
{
	WinGet, Style, Style, %WinTitle%
	Transform, Result, BitAnd, %Style%, 0x10000000 ; 0x10000000 is WS_VISIBLE.
	if Result <> 0 ;Window is Visible
		Return 1
	Else  ;Window is Hidden
		Return 0
}

Scratchpad_PositionCenteredPercent(width, height) {
	positionX := (1 - width) / 2 * A_ScreenWidth
	positionY := (1 - height) / 2 * A_ScreenHeight
	width := width * A_ScreenWidth
	height := height * A_ScreenHeight

	Return [positionX, positionY, width, height]
}

Scratchpad_PositionCenteredPixels(width, height) {
	positionX := (A_ScreenWidth - width) / 2
	positionY := (A_ScreenHeight - height) / 2

	Return [positionX, positionY, width, height]
}

; Terminal
^!S::
	EnvGet, userprofile, USERPROFILE

	identifier := "scratchpad ahk_exe alacritty.exe"
	command = "alacritty" "-t" "scratchpad" "--working-directory" "%userprofile%"
	position := Scratchpad_PositionCenteredPercent(0.9, 0.9)

	Scratchpad_Action(identifier, command, position)
Return
