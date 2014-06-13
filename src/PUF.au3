#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.10.2
 Author:         voidmous

 Script Function:
	Pop Up Framwork
	Bind hotkeys to pop up user specified windows like dropdown terminal Tilda.

#ce ----------------------------------------------------------------------------

#NoTrayIcon
#include <lib/TrayConstants.au3>    ; Required for the $TRAY_CHECKED constant.
#include <lib/Misc.au3>             ; Required by _IsPressed()
#include <lib/MsgBoxConstants.au3>
#include <lib/Array.au3>


Opt("TrayMenuMode", 3)
; The default tray menu items will not be shown and items are not checked
; when selected. These are options 1 and 2 for TrayMenuMode.

GLobal $DEBUGFLAG = 0  ; Debug mode toggle

Global $IniPath = StringFormat("%s\PUF.ini",@ScriptDir)
; Ini file is kept within same dir as PUF.exe

Global $hDLL = DllOpen("user32.dll")
Global $ExtKeys[]=["5B", "5C", "A0", "A1", "A2", "A3", "A4", "A5"]
   ;   5B Left Windows key
   ;   5C Right Windows key
   ;   A0 Left SHIFT key
   ;   A1 Right SHIFT key
   ;   A2 Left CONTROL key
   ;   A3 Right CONTROL key
   ;   A4 Left MENU key
   ;   A5 Right MENU key
; Extended keys which cannot bind by HotKeySet() yet recognizable by _IsPressed()
; http://www.autoitscript.com/autoit3/docs/libfunctions/_IsPressed.htm

; Read cfg file "PUF.ini" orelse write default configuration
If Not FileExists($IniPath) Then
   ; If file does not exist, creat one
   MsgBox(4096, "", "PUF.ini not found, using default.")
   IniWrite($IniPath, "^q", "WinTitle", "Xshell") 	; Write default info into ini file
   IniWrite($IniPath, "^q", "WinClass", "Xshell4:MainWnd")
   IniWrite($IniPath, "^q", "ExePath", "C:\Program Files\NetSarang\Xshell 4\Xshell.exe")
   IniWrite($IniPath, "^m", "WinName", "bash")
   IniWrite($IniPath, "^m", "WinClass", "mintty")
   IniWrite($IniPath, "^m", "ExePath", "C:\cygwin\bin\mintty -")
   IniWrite($IniPath, "^e", "WinName", "emacs")
   IniWrite($IniPath, "^e", "WinClass", "Emacs")
   IniWrite($IniPath, "^e", "ExePath", "C:\cygwin\bin\emacs-w32.exe")
EndIf
$IniSectionNames = IniReadSectionNames($IniPath)
; Read all section names from ini file. $IniSectionNames is an array.
; $IniSectionNames[0] stores number of sections,
; $IniSectionNames[1]--$IniSectionNames[$IniSectionNames[0]] store names of sections.
; Read all hotkeys and bind to _PUF function
For $i = 1 To $IniSectionNames[0]
   $AppKeyBind = $IniSectionNames[$i] ; Read all keys and bind to function _PUF()
   If $DEBUGFLAG Then
   MsgBox(4096, "AutoIt Debug", StringFormat("Key No. %d is %s", $i, $AppKeyBind))
   EndIf
   $Index = _ArraySearch($ExtKeys, $AppKeyBind)
   If  $Index == -1 Then
	  HotKeySet($AppKeyBind, "_PUF")
   Else
	  ; Extended keys should not bind with HotKeySet()
	  ; TODO
   EndIf
Next

; TrayMenu() contains a infinite-while-loop
; Has to be put in the end
TrayMenu()

; Must be called not processed, hence behind a infinite-loop
Func _PUF()
   ; @HotKeyPressed records the last key(Registered with HotKeySet()) pressed
   ; More about @HotKeyPressed, see website:
   ; http://www.autoitscript.com/forum/topic/63526-hotkeyset-function-parameters/
   ;MsgBox(4096, "AutoIt Debug", @HotKeyPressed)
   $AppKeyBind=@HotKeyPressed
   $Section=IniReadSection($IniPath,$AppKeyBind)   ; Read value of section @HotKeyPressed
   For $i = 1 To $Section[0][0]
	  If $section[$i][0] = "WinTitle" Then
		 Local $AppTitle = $section[$i][1]   ; Search and set local variable $AppTitle
	  EndIf
	  If $section[$i][0] = "WinClass" Then
		 Local $AppClass = $section[$i][1]   ; Search and set local variable $AppClass
	  EndIf
	  If $section[$i][0] =  "ExePath" Then
		 Local $AppExePath = $section[$i][1]    ; Search and set local variable $AppExePath
	  EndIf
   Next
   If $DEBUGFLAG Then
      MsgBox(4096,"", $AppTitle & $AppClass & $AppExePath)
   EndIF
   ; Opt("WinTextMatchMode",2) ; Quick text searching mode
   Opt("WinTitleMatchMode",4)
   ; Advanced matching mode, handle, class and title supported
   ; '-4' instead of '4' denotes case insensitive matching
   ; 1=startstr, 2=substr, 3=exact, 4=advanced, -1 to -4=nocase
   ; CLASS matching with priority, TITLE matching at 2nd place
   If WinExists("[CLASS:" & $AppClass & "]") Then
      Local $hWND = WinGetHandle("[CLASS:" & $AppClass & "]")
      If $DEBUGFLAG Then
	     MsgBox(4096,"AutoIt Debug","An window " & $hWND & "is found by Class")
	  EndIf
      If WinActive($hWND) Then
         WinSetState($hWND, "", @SW_MINIMIZE)  ; If window is avtive, then minimize it
      Else
         WinActivate($hWND) ; If window is not active, then activate it
      EndIf
   Else
      Opt("WinTitleMatchMode",2) ; Matching title with mode 2
      If $DEBUGFLAG Then
         MsgBox(4096, "", "No window found by Class")
      EndIf
      If WinExists($AppTitle) Then
         Local $hWND = WinGetHandle($AppTitle)
         If $DEBUGFLAG Then
		   MsgBox(4096,"AutoIt Debug","An window " & $hWND & "is found by title")
	     EndIf
         If WinActive($hWND) Then
            WinSetState($hWND, "", @SW_MINIMIZE)  ; If window is avtive, then minimize it
         Else
            WinActivate($hWND) ; If window is not active, then activate it
         EndIf
      Else
         If $DEBUGFLAG Then
		    MsgBox(4096,"AutoIt Debug","No instance running, start one now.")
	     EndIf
	     Run($AppExePath)
	     WinWait($AppTitle)
      EndIf
   EndIf
EndFunc


Func TrayMenu()
   Local $mAdd = TrayCreateItem("Add")
   TrayCreateItem("")
   Local $mAddTemp = TrayCreateItem("AddTemp")
   TrayCreateItem("")
   Local $mDebug = TrayCreateItem("Debug")
   TrayCreateItem("") ; Create a separator line.
   Local $mAbout = TrayCreateItem("About")
   TrayCreateItem("") ; Create a separator line.
   Local $mExit = TrayCreateItem("Exit")

   TraySetState(1) ; Show the tray menu.
   TraySetToolTip("Pop Up Framework is watching you.")

   While 1
      Switch TrayGetMsg()
         Case $mAddTemp
            $confirm = 1
            $mouseClicked = 0
            MsgBox(4096,"","Click(activate) the temporary window you want to add, you may use CTRL+TAB")
            While $confirm
               If _IsPressed("01") Then   ; If left mouse is clicked, then get the window handle
                  $AddTempHandle = WinGetHandle("") ; Return the handle of currently active window
                  $choice = MsgBox($MB_CANCELTRYCONTINUE, "", "Window Handle: " & $AddTempHandle & _
                     @CRLF & "Window Title: " & WinGetTitle($AddTempHandle) & @CRLF & _
                     "Is it right?") ; Make sure right window is choosen
                  If $choice = 11 Then ; Choice is right, continue
                     $confirm = 0
                     If $DEBUGFLAG Then
                        MsgBox(4096, "", "Choosen window is :" & WinGetTitle($AddTempHandle))
                     Endif
                  Elseif $choice = 10 Then ; Choice is wrong, try again
                  $confirm = 1
                  Else ; Cancel
                  $confirm = 0
                  Endif
               Endif
            Wend
         Case $mDebug
         ; Toggle debug mode
            $DEBUGFLAG = not $DEBUGFLAG
            If $DEBUGFLAG Then
               MsgBox(4096, "", "Debug mode is on")
            Else
               MsgBox(4096, "", "Debug mode is off")
            EndIF
         Case $mAbout
         ; Display a message box about the AutoIt version and installation path of the AutoIt executable.
            MsgBox($MB_SYSTEMMODAL, "", "Pup Up Framework" & @CRLF & @CRLF & _
            "By: voidmous#gmail.com" & @CRLF & _
            "Version: " & @AutoItVersion & @CRLF & _
            "Install Path: " & StringLeft(@AutoItExe, StringInStr(@AutoItExe, "\", 0, -1) - 1))
         Case $mExit ; Exit the loop.
			Dllclose($hDLL)
            ExitLoop
      EndSwitch
    WEnd

EndFunc