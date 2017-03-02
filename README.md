# PUF

## What is it?

PUF is Pop Up Framework, which intends to pop up desired program window with keyboard shortcut. PUF is inspired by [cyg-hotkey](https://bitbucket.org/riverscn/cyg-hotkey)
 and "steals" some code from it too. It's written originally in [AHK_L](http://www.autohotkey.com/ )

## Why use it?

Why is it useful? Think about the scene, you're watching a class video with a narrow-width lcd display in full-screen mode. If you want to take notes, then you have to pause the video and switch from player to note-taking program such as evernote. It's a waste of time and energy. Why not 'summon' evernote with only one keyboard hit just like [Tilda](http://tilda.sourceforge.net/tildaabout.php). In summary, it's very convenient with PUF when we want to:

* Take notes when you have to switch back and forth
* Test short commands while watching tutorial on the web

Of course you can make life easier in other ways like:

* Use 2 LCD displayers ( need money and space )
* Make 2 windows side by side ( need to adjust and may not be so comfortable )

but a third option is always welcomed, isn't it?

## How to run?

### Compilation

* On windows, run `makefile.bat`
* On cygwin, run `make package` to generate tar.gz package for installation, `make clean` to remove generated files.

### Installation

Unzip the generated tar.gz package and run `PUF*.exe` according to your CPU architecture, then you have the ablility to call

* `Notepad` with `F7`
* `cmd.exe` with `F8`

as with default configuration if that is correct with your case. Or you can install AHK and directly run the script without compilation(more convenient for debugging).

### Customization

You have to manually modify codes to customization, but it's easy as well.
The configuration is stored all in `PUF.ini`. Modify it as following example:

```ini
[{f7}]
Name=Notepad
Path=C:\Windows\System32\notepad.exe
[{f8}]
Name=cmd.exe
Path=C:\Windows\system32\cmd.exe
```
As you can see, section name is set to hotkey name e.g. [{f7}], each section has two keys
`Name` (Program window title substring for window searching) and `Path` (Absolute path of executable file). Most importanly, do write the correct shortcut key name, see [Send key list](http://www.autoitscript.com/autoit3/docs/appendix/SendKeys.htm) for more information.



## FAQ

### How to decide which key to bind?

If you don't know the key name, take a quick look at 
[Hotkeys (Mouse, Joystick and Keyboard Shortcuts)](http://www.autohotkey.com/docs/Hotkeys.htm ).

### How to choose Name?

Watch the title column of the window, or run `tool\Au3Info.exe` to see
more comprehensive properties.

### Do NOT use a starter command before real executable file

This may interfere AHK locating the target window

### Run As Administrator

If you run PUF as Administrator, then all application you start with PUF will be run as Administrator automatically.
