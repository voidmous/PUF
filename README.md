# PUF

## What is it?

PUF is Pop Up Framework, which intends to pop up desired program window with keyboard 
shortcut. PUF is inspired by [cyg-hotkey](https://bitbucket.org/riverscn/cyg-hotkey)
 and "steals" some code from it too. It's written in [AHK Basic](http://ahkscript.org/).

## Why use it?

Why is it useful? Think about the scene, you're watching a class video with a narrow-width
lcd display in full-screen mode. If you want to take notes, then you have to pause the video 
and switch from player to note-taking program such as evernote. It's a waste of time and 
energy. Why not 'summon' evernote with only one keyboard hit just like [Tilda](http://tilda.sourceforge.net/tildaabout.php). In summary, it's very convenient with PUF when we want to:

* Take notes when you have to switch back and forth
* Test short commands while watching tutorial on the web

## How to do?

### Installation

Copy the pre-compiled `bin/puf.exe` to wherever you like and double-click, then you have the
ablility to call

* `Xshell` with `F7`
* `Everything` with `F8`
* `Evernote` with `F9`

as with default configuration. Or you can install AHK and directly run the script
without compilation(more convenient for debugging).

### Customization

You have to manually modify codes to customization, but it's easy as well.
Copy the following codes to `puf.ahk` where appropriate and modify
 the binded key `f7`, `WinName` and `ExePath`
according to your computer. Only one thing to notice, WinName must be 
an unique string in the title of the window so that the window can be
searched and located exactly. 

```ahk
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
```
### Compilation

<dl>
  <dt><strong>Without cygwin</strong></dt>
  <dd>Manually compile with `ahkc/Ahk2Exe.exe`, just double click.</dd>
  <dt><strong>Under cygwin</strong></dt>
  <dd>Simply make</dd>
</dl>

## Where to go?

Since AHK Basic cannot dynamically bind key-shortcuts, the implementation 
is very silly. With AHK_L version the code may be more brief, see [the discussion](http://stackoverflow.com/questions/12851677/dynamically-create-autohotkey-hotkey-to-function-subroutine). 
Unfortunatlly, I'm not familiar with AHK_L. AutoIt may be a solution too.

## FAQ

* How to decide which key to bind?

Install [Windows Hotkey Explorer](http://hkcmdr.anymania.com/) to see
keys already bind.

* How to choose WinName?
Watch the title column of the window, or use `ahkc/AU3_Spy.exe` to see
more comprehensive properties.