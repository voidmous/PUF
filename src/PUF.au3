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

Opt("TrayMenuMode", 3)
; The default tray menu items will not be shown and items are not checked
; when selected. These are options 1 and 2 for TrayMenuMode.

$DEBUGFLAG = 0  ; Debug mode toggle

$IniPath = StringFormat("%s\PUF.ini",@ScriptDir)
; Ini file is kept within same dir as PUF.exe

; Read cfg file "PUF.ini" or write default configuration
If FileExists($IniPath) Then
   $IniSectionNames = IniReadSectionNames($IniPath)
   ; Read all section names from ini file. $IniSectionNames is an array.
   ; $IniSectionNames[0] stores number of sections,
   ; $IniSectionNames[1]--$IniSectionNames[$IniSectionNames[0]] store names of sections.
   If @error Then
	  MsgBox(4096, "", "Error, ini file may not be valid")
   EndIf
Else
   MsgBox(4096, "", "PUF.ini not found, using default.")
   IniWrite($IniPath, "{f7}", "Name", "Xshell") 	; Write default info into ini file
   IniWrite($IniPath, "{f7}", "Path", "C:\Program Files\NetSarang\Xshell 4\Xshell.exe")
   IniWrite($IniPath, "{f8}", "Name", "cmd.exe")    ; Write default info into ini file
   IniWrite($IniPath, "{f8}", "Path", "C:\Windows\system32\cmd.exe")
   IniWrite($IniPath, "{f9}", "Name", "emacs")
   IniWrite($IniPath, "{f9}", "Path", "C:\cygwin\bin\emacs-w32.exe")
   $IniSectionNames = IniReadSectionNames($IniPath)
EndIf
; Read all hotkeys and bind to _PUF function
For $i = 1 To $IniSectionNames[0]
   $AppKeyBind = $IniSectionNames[$i] ; Read all keys and bind to function _PUF()
   If $DEBUGFLAG Then
   MsgBox(4096, "AutoIt Debug", StringFormat("Key No. %d is %s", $i, $AppKeyBind))
   EndIf
   HotKeySet($AppKeyBind, "_PUF")   ; Bind the keyboard shortcut
Next


TrayMenu()

Func _PUF()
   ; @HotKeyPressed records the last key(Registered with HotKeySet()) pressed
   ; More about @HotKeyPressed, see website:
   ; http://www.autoitscript.com/forum/topic/63526-hotkeyset-function-parameters/
   ;MsgBox(4096, "AutoIt Debug", @HotKeyPressed)
   $AppKeyBind=@HotKeyPressed
   $Section=IniReadSection($IniPath,$AppKeyBind)   ; Read value of section @HotKeyPressed
   If @error Then
    MsgBox(4096, "", "Error, ini file may not be valid")
   Else
      For $i = 1 To $section[0][0]
         If $section[$i][0] = "Name" Then
            Local $AppTitle = $section[$i][1]   ; Search and set local variable $Apptitle
         EndIf
         If $section[$i][0] =  "Path" Then
            Local $AppExePath = $section[$i][1]    ; Search and set local variable $AppExePath
         EndIf
      Next
   EndIf

   ;Opt("WinTitleMatchMode",4) ; Advanced matching mode, handle and class supported
   Opt("WinTitleMatchMode", 2) ; Substring matching mode
   If WinExists($AppTitle) Then  ; An instance is running
	   If $DEBUGFLAG Then
		   MsgBox(4096,"AutoIt Debug","An instance is running, switch its status now.")
	   EndIf
      If WinActive($AppTitle) Then
         WinSetState($AppTitle, "", @SW_MINIMIZE)  ; If window is avtive, then minimize it
      Else
         WinActivate($AppTitle) ; If window is not active, then activate it
      EndIf
   Else
	   If $DEBUGFLAG Then
		   MsgBox(4096,"AutoIt Debug","No instance running, start one now.")
	   EndIf
	   Run($AppExePath)
	   WinWait($AppTitle)
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
            ExitLoop
      EndSwitch
    WEnd

EndFunc
