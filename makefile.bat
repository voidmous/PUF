set SRC=src\PUF.au3
set ICO=res\greencloud.ico
set CC=tool\Aut2exe.exe
set EXE=bin\PUF.exe

%CC% /in %SRC% /out %EXE% /icon %ICO% 
PAUSE