# PUF

## What is it?

PUF is Pop Up Framework, which intends to pop up desired program window with keyboard 
shortcut. PUF is inspired by [cyg-hotkey](https://bitbucket.org/riverscn/cyg-hotkey)
 and "steals" some code from it too. 
 
I've implemented PUF with 2 script languages: 
[`AutoIt v3`](https://github.com/voidmous/PUF/tree/au3-devel) and 
[`AutoHotKey_L`](https://github.com/voidmous/PUF/tree/ahk-devel), 
partly in order to compare their features.

Here are my comments on them:

1. Readability. `AutoIt` is much better at least for me due to its strict
and unified syntax.
2. Documentation. `AutoIt` beats `AHK_L`. The document of `AHK_L` is organized
like a disaster.
3. Hotkey feature. `AHK_L` can bind more keys even though it actually 
breaks the traditional rules about hotkey binding.
4. OOP. `AHK_L` is now OO language while `AutoIt` seems not.
