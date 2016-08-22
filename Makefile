SRC = PUF.ahk
EXEC = PUF.exe
EXEC_ANSI = PUFansi.exe
EXEC32 = PUF32b.exe
EXEC64 = PUF64b.exe
CC = tool/Ahk2Exe.exe
ICO = res/PUF.ico
# INSTALLDIR = $(shell cygpath -P)/Startup/ # Windows启动文件夹
INSTALLDIR = $(shell cygpath D\:/Program\ Files/PUF/)
SHA1 = $(shell git rev-parse HEAD)
#BRANCHN = $(SHA1)_$(shell date +%F-%H%M%S)
BRANCHN = $(shell date +%F-%H%M%S)

bin: bin64 # 默认生成64bit binary

bin_ansi: # ANSI binary
#ifeq ($(wildcard bin),) # make directory bin/
#	@mkdir bin
#endif
	$(CC) /in $(SRC) /out $(EXEC_ANSI) /icon $(ICO) /bin "tool/ANSI 32-bit.bin"

bin32: # Unicode 32bit binary
	$(CC) /in $(SRC) /out $(EXEC32) /icon $(ICO) /bin "tool/Unicode 32-bit.bin"

bin64: # Unicode 64bit binary
	$(CC) /in $(SRC) /out $(EXEC64) /icon $(ICO) /bin "tool/Unicode 64-bit.bin"

clean:
	rm -rf $(EXEC_ANSI) $(EXEC32) $(EXEC64) pkg/

install: bin
	cp -f $(EXEC) "$(INSTALLDIR)"
	cp -f $(ICO) "$(INSTALLDIR)"

package: bin_ansi bin32 bin64
ifeq ($(wildcard pkg),) # make directory pkg/
	@mkdir pkg
endif
	tar -zcvf pkg/PUF_$(BRANCHN).tar.gz $(EXEC_ANSI) $(EXEC32) $(EXEC64) PUF.ini tool res LICENSE README.md

all: bin_ansi bin32 bin64 package
