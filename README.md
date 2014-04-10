# PUF

## What is it?

PUF is Pop Up Framework, which intends to pop up desired program window with keyboard 
shortcut. PUF is inspired by [cyg-hotkey](https://bitbucket.org/riverscn/cyg-hotkey)
 and "steals" some code from it too. It's written originally in [AHK Basic](http://ahkscript.org/) and has been re-implemented in [AutoItV3](http://www.autoitscript.com/site/) (Due to dynamical key binding limitation of AHK Basic).

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
* `cmd.exe` with `F8`
* `Evernote` with `F9`

as with default configuration. Or you can install AHK and directly run the script
without compilation(more convenient for debugging).

### Customization

You have to manually modify codes to customization, but it's easy as well.
The configuration is stored in `PUF.ini`. Modify it as following example:

```ini
[{f7}]
Name=Xshell
Path=C:\Program Files\NetSarang\Xshell 4\Xshell.exe
[{f8}]
Name=cmd.exe
Path=C:\Windows\system32\cmd.exe
```
As you can see, section name is set to hotkey name, each section has two keys
`Name` (Program window title substring for window searching) and `Path` (Absolute path of executable file). Most importanly, do write the correct shortcut key name, see [Send key list](http://www.autoitscript.com/autoit3/docs/appendix/SendKeys.htm) for more information.

### Compilation

Run `makefile.bat` will generate `bin\PUF.exe`.

## FAQ

* How to decide which key to bind?

At first, there are [limitations](https://www.autoitscript.com/autoit3/docs/functions/HotKeySet.htm) of key binding with `HotKeySet()`:

<table>
  <tr>
    <td style="width:15%">Ctrl+Alt+Delete</td>
    <td style="width:85%">It is reserved by Windows</td>
  </tr>
  <tr>
   <td>F12</td>
   <td>It is also reserved by Windows, according to its API.</td>
  </tr>
  <tr>
   <td>NumPad's Enter Key</td>
   <td>Instead, use {Enter} which captures both Enter keys on the keyboard.</td>
  </tr>
  <tr>
   <td>Win+B,D,E,F,L,M,R,U; and Win+Shift+M</td>
   <td>These are built-in Windows shortcuts.  Note:  Win+B and Win+L might only be reserved on Windows XP and above.</td>
  </tr>
  <tr>
   <td>Alt, Ctrl, Shift, Win</td>
   <td>These are the modifier keys themselves!</td>
  </tr>
  <tr>
   <td>Other</td>
   <td>Any global hotkeys a user has defined using third-party software,  any combos of two or more "base keys" such as '{F1}{F2}', and any keys of the form '{LALT}' or '{ALTDOWN}'.</td>
  </tr>
</table>

Install [Windows Hotkey Explorer](http://hkcmdr.anymania.com/) to see
keys already bind.

* How to choose Name?

Watch the title column of the window, or use `tool\Au3Info.exe` to see
more comprehensive properties.