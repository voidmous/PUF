debug := False 	; Output debug info if debug is True
SetTitleMatchMode, 2 	; Matching window whose title contain(not exactly equals to) WinTitle

;;;;;;;;;;;;;;;;;;;;;;;; Tray Menu Settings

Menu, TRAY, Tip, Pop Up Framework 	; Tray icon help info when hovering up
Menu, TRAY, Icon
Menu, TRAY, NoStandard
Menu, TRAY, add, Null
Menu, TRAY, Disable, Null
Menu, TRAY, Rename, Null, Ver 0.1 	; Display "Ver 0.1"
Menu, TRAY, add, Debug 	; Debug mode toggle
Menu, TRAY, add, Help 	; Display help info
Menu, TRAY, add, Exit 	; Exit app

;;;;;;;;;;;;;;;;;;;;;;;; Pop Up Function Key Binding

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Key binding block example start
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
f7::
WinName := "Xshell"
ExePath := "C:\Program Files\NetSarang\Xshell 4\Xshell.exe"
IfWinExist, %WinName% 	; Find window whose WinTitle contains %WinName%
{
	if debug
		MsgBox, 4096,, window whose title contains %WinName% has been found

	WinGet, WinUID, IDLast, %WinName%	; Get uid of the window and store it in WinUID
	if debug
		MsgBox, 4096,, Window UID is WinUID

	WinSet, AlwaysOnTop, On, ahk_id %WinUID%	; Set the window always on top
	WinGet, WinMinMax, MinMax, ahk_id %WinUID%
	; Get the MinMax status of the window and store it in WinMinMax
	; MinMax=-1, minimized, use WinRestore to restore default status
	; MinMax=1, maximized, use WinRestore to restore default status
	; MinMax=0, neither minimized nor maximized

	If (WinMinMax = -1)	; If minimized, then restore and activate the window
		{
			if debug
				MsgBox, 4096,, The window is minimized, restore and activate it!
			WinRestore, ahk_id %WinUID%
			WinActivate, ahk_id %WinUID%
		}
	Else
		{
			if debug
				MsgBox, 4096,, The window is not minimized, minimize it!
			WinMinimize, ahk_id %WinUID%	; If not minimized, then minimize the window
		}
}
Else    ; If desired process not running, create one
{
	if debug
		MsgBox, 4096,, No matching window found, create one!
	Run,%ExePath%,
	WinWait, %WinName%		; Wait untill window popup
	WinSet, AlwaysOnTop, On 	; Set the new window always on top
	Return 		; End keyfunction-block when window created
}
Return 		; End keyfunction-block when window MinMax status changed
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Key binding block example end
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

f8::
WinName := "Everything"
ExePath := "D:\Program Files\Everything\Everything.exe"
IfWinExist, %WinName% 	; Find window whose WinTitle contains %WinName%
{
	if debug
		MsgBox, 4096,, window whose title contains %WinName% has been found

	WinGet, WinUID, IDLast, %WinName%	; Get uid of the window and store it in WinUID
	if debug
		MsgBox, 4096,, Window UID is WinUID

	WinSet, AlwaysOnTop, On, ahk_id %WinUID%	; Set the window always on top
	WinGet, WinMinMax, MinMax, ahk_id %WinUID%
	; Get the MinMax status of the window and store it in WinMinMax
	; MinMax=-1, minimized, use WinRestore to restore default status
	; MinMax=1, maximized, use WinRestore to restore default status
	; MinMax=0, neither minimized nor maximized

	If (WinMinMax = -1)	; If minimized, then restore and activate the window
		{
			if debug
				MsgBox, 4096,, The window is minimized, restore and activate it!
			WinRestore, ahk_id %WinUID%
			WinActivate, ahk_id %WinUID%
		}
	Else
		{
			if debug
				MsgBox, 4096,, The window is not minimized, minimize it!
			WinMinimize, ahk_id %WinUID%	; If not minimized, then minimize the window
		}
}
Else    ; If desired process not running, create one
{
	if debug
		MsgBox, 4096,, No matching window found, create one!
	Run,%ExePath%,
	WinWait, %WinName%		; Wait untill window popup
	WinSet, AlwaysOnTop, On 	; Set the new window always on top
	Return 		; End keyfunction-block when window created
}
Return 		; End keyfunction-block when window MinMax status changed


f9::
WinName := "Evernote"
ExePath := "C:\Program Files\Evernote\Evernote\Evernote.exe"
IfWinExist, %WinName% 	; Find window whose WinTitle contains %WinName%
{
	if debug
		MsgBox, 4096,, window whose title contains %WinName% has been found

	WinGet, WinUID, IDLast, %WinName%	; Get uid of the window and store it in WinUID
	if debug
		MsgBox, 4096,, Window UID is WinUID

	WinSet, AlwaysOnTop, On, ahk_id %WinUID%	; Set the window always on top
	WinGet, WinMinMax, MinMax, ahk_id %WinUID%
	; Get the MinMax status of the window and store it in WinMinMax
	; MinMax=-1, minimized, use WinRestore to restore default status
	; MinMax=1, maximized, use WinRestore to restore default status
	; MinMax=0, neither minimized nor maximized

	If (WinMinMax = -1)	; If minimized, then restore and activate the window
		{
			if debug
				MsgBox, 4096,, The window is minimized, restore and activate it!
			WinRestore, ahk_id %WinUID%
			WinActivate, ahk_id %WinUID%
		}
	Else
		{
			if debug
				MsgBox, 4096,, The window is not minimized, minimize it!
			WinMinimize, ahk_id %WinUID%	; If not minimized, then minimize the window
		}
}
Else    ; If desired process not running, create one
{
	if debug
		MsgBox, 4096,, No matching window found, create one!
	Run,%ExePath%,
	WinWait, %WinName%		; Wait untill window popup
	WinSet, AlwaysOnTop, On 	; Set the new window always on top
	Return 		; End keyfunction-block when window created
}
Return 		; End keyfunction-block when window MinMax status changed



Debug:
debug := not debug
If debug
	MsgBox, 4096,, Debug mode is on.
Else
	MsgBox, 4096,, Debug mode is off.
Return

Help:
; display help info
Return

Exit:
ExitApp

Null:
return