SRC = src/PUF.ahk
EXEC = bin/PUF.exe
CC = tool/Ahk2Exe.exe
ICO = res/shield_and_swords.ico
# INSTALLDIR = $(shell cygpath -P)/Startup/ # Windows启动文件夹
INSTALLDIR = $(shell cygpath D\:/Program\ Files/PUF/)
SHA1 = $(shell git rev-parse HEAD)
BRANCHN =$(SHA1)_$(shell date +%F-%H%M%S)

bin:
ifeq ($(wildcard bin),)
	@mkdir bin
endif
	$(CC) /in $(SRC) /out $(EXEC) /icon $(ICO) /bin tool/AutoHotkeySC.bin

clean:
	rm -rf bin/ pkg/

install: bin
	cp -f $(EXEC) "$(INSTALLDIR)"

package:
ifeq ($(wildcard pkg),)
	@mkdir pkg
endif
	tar -zcvf pkg/PUF_$(BRANCHN).tar.gz src bin tool/Au3_Spy.exe LICENSE README.md

all: bin package