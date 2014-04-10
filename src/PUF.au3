#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.10.2
 Author:         voidmous

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------
#NoTrayIcon
#include <TrayConstants.au3> ; Required for the $TRAY_CHECKED constant.
#include <MsgBoxConstants.au3>

Opt("TrayMenuMode", 3) ; The default tray menu items will not be shown and items are not checked when selected. These are options 1 and 2 for TrayMenuMode.

$debug = 0  ; Debug mode toggle

$IniPath = StringFormat("%s\PUF.ini",@ScriptDir) 	; Ini file within same dir as puf.exe
If FileExists($IniPath) Then
   $IniSectionNames = IniReadSectionNames($IniPath) 	; Read all section names from ini file
   ; $IniSectionNames is an array, $IniSectionNames[0] stores number of sections,
   ; $IniSectionNames[1]--$IniSectionNames[$IniSectionNames[0]] store names of sections.
   If @error Then
	  MsgBox(4096, "", "Error, ini file may not be valid")
   EndIf
Else
   MsgBox(4096, "", "puf.ini not found, using default.")
   IniWrite($IniPath, "{f7}", "Name", "Xshell") 	; Write default info into ini file
   IniWrite($IniPath, "{f7}", "Path", "C:\Program Files\NetSarang\Xshell 4\Xshell.exe")
   IniWrite($IniPath, "{f8}", "Name", "cmd.exe")    ; Write default info into ini file
   IniWrite($IniPath, "{f8}", "Path", "C:\Windows\system32\cmd.exe")
   $IniSectionNames = IniReadSectionNames($IniPath)
EndIf

For $i = 1 To $IniSectionNames[0]
   $AppKeyBind = $IniSectionNames[$i] ; Read all keys and bind to function _PUF()
   If $debug Then
   MsgBox(4096, "AutoIt Debug", StringFormat("Key No. %d is %s", $i, $AppKeyBind))
   EndIf
   HotKeySet($AppKeyBind, "_PUF")   ; Bind the keyboard shortcut
Next


TrayMenu()

Func _PUF()
   ; @HotKeyPressed records the last key(Registered with HotKeySet()) pressed
   ; More about @HotKeyPressed, see http://www.autoitscript.com/forum/topic/63526-hotkeyset-function-parameters/
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
	   If $debug Then
		   MsgBox(4096,"AutoIt Debug","An instance is running, switch its status now.")
	   EndIf
      If WinActive($AppTitle) Then
         WinSetState($AppTitle, "", @SW_MINIMIZE)  ; If window is avtive, then minimize it
      Else
         WinActivate($AppTitle) ; If window is not active, then activate it
      EndIf
   Else
	   If $debug Then
		   MsgBox(4096,"AutoIt Debug","No instance running, start one now.")
	   EndIf
	   Run($AppExePath)
	   WinWait($AppTitle)
   EndIf

EndFunc

Func TrayMenu()
   Local $mDebug = TrayCreateItem("Debug")
   TrayCreateItem("") ; Create a separator line.
   Local $mAbout = TrayCreateItem("About")
   TrayCreateItem("") ; Create a separator line.
   Local $mExit = TrayCreateItem("Exit")

   TraySetState(1) ; Show the tray menu.
   TraySetToolTip("Pop Up Framework is watching you.")

   While 1
      Switch TrayGetMsg()
         Case $mDebug
         ; Toggle debug mode
         $debug = not $debug
         If $debug Then
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
