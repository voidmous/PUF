set SRC=PUF.ahk
set ICO=res\PUF.ico
set CC=tool\Ahk2Exe.exe
set EXE=bin\PUF.exe
set BIN64="tool\Unicode 64-bit.bin"

%CC% /in %SRC% /out %EXE% /icon %ICO% /bin %BIN64%
PAUSE