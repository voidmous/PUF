#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

DEBUGFLAG := False	; Output debug info if DEBUGFLAG is True
IniPath :=  A_ScriptDir  . "\PUF.ini"
SetTitleMatchMode, 2 	; Matching window whose title contain(not exactly equals to) WinTitle

;;;;;;;;;;;;;;;;;;;;;;;; Check If Ini File Exists
If (NOT FileExist(IniPath))
{
	MsgBox, 4096,, Ini file not found, using default one
	IniWrite, Emacs, %IniPath%, AppsKey, WinTitle
	IniWrite, Emacs, %IniPath%, AppsKey, WinClass
	IniWrite, C:\cygwin\bin\emacs-w32.exe, %IniPath%, AppsKey, ExePath
	IniWrite, bash, %IniPath%, RAlt, WinTitle
	IniWrite, mintty, %IniPath%, RAlt, WinClass
	IniWrite, C:\cygwin\bin\mintty -, %IniPath%, RAlt, ExePath
	IniWrite, Xshell, %IniPath%, RCtrl, WinTitle
	IniWrite, Xshell4:MainWnd, %IniPath%, RCtrl, WinClass
	IniWrite, C:\Program Files\NetSarang\Xshell 4\Xshell.exe, %IniPath%, RCtrl, ExePath
}

;;;;;;;;;;;;;;;;;;;;;;;; Read Hot Keys And Bind Them All
IniRead, Keys, %IniPath%
StringReplace, Keys, Keys, `n, %A_Space%, All  ; ` escapses "\n"
; To split string with a substring delimeter, you've to replace substring with one character
StringSplit, KeysArray, Keys, %A_Space%
If DEBUGFLAG
	MsgBox, 4096,, %KeysArray0% %KeysArray1% %KeysArray2%

i := 1
While (i != KeysArray0+1)
{	
	KeyName := KeysArray%i%
	HotKey, %KeyName%, _PUF
	If DEBUGFLAG
		MsgBox, 4096,, HotKey sucessfully bind
	i := i+1
}

while true
{
	Sleep,250
}
; _PUF has to be put after a while loop
;;;;;;;;;;;;;;;;;;;;;;;; Pop Up Function Key Binding
_PUF:
	AppKey = %A_ThisHotkey%
	If DEBUGFLAG
		MsgBox,4096,, "Hotkey detected " . %AppKey%
	IniRead, AppTitle, %IniPath%, %AppKey%, WinTitle, Null
	IniRead, AppClass, %IniPath%,  %AppKey%, WinClass, Null
	IniRead, AppPath, %IniPath%,  %AppKey%, ExePath, Null
	If DEBUGFLAG
		MsgBox, %AppTitle% %AppClass% %AppPath%
	hWND := WinExist("ahk_class" . AppClass)
	If hWND
	{
		WinSet, AlwaysOnTop, On, ahk_id %hWND%	; Set the window always on top
		WinGet, WinMinMax, MinMax, ahk_id %hWND%
		; Get the MinMax status of the window and store it in WinMinMax
		; MinMax=-1, minimized, use WinRestore to restore default status
		; MinMax=1, maximized, use WinRestore to restore default status
		; MinMax=0, neither minimized nor maximized
		If (WinMinMax = -1)	; If minimized, then restore and activate the window
		{
			if DEBUGFLAG
				MsgBox, 4096,, The window is minimized, restore and activate it!
			WinRestore, ahk_id %hWND%
			WinActivate, ahk_id %hWND%
		}
		Else
		{
			if DEBUGFLAG
				MsgBox, 4096,, The window is not minimized, minimize it!
			WinMinimize, ahk_id %hWND%	; If not minimized, then minimize the window
		}
	}
	else  ; If desired process not running, create one
	{
		if DEBUGFLAG
			MsgBox, 4096,, No matching window found, create one!
		Run,%AppPath%
		WinWait, %AppTitle%		; Wait untill window popup
		WinSet, AlwaysOnTop, On 	; Set the new window always on top
	}
return



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

;;;;;;;;;;;;;;;;;;;;;;; Tray Events Settings
Debug:
DEBUGFLAG := not DEBUGFLAG
If DEBUGFLAG
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
