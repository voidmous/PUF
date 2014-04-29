SRC = src/PUF.au3
EXEC = bin/PUF.exe
CC = tool/Aut2exe.exe
ICO = res/greencloud.ico
INSTALLDIR = $(shell cygpath -P)/Startup/
SHA1 = $(shell git rev-parse HEAD)
BRANCHN =$(SHA1)_$(shell date +%F-%H%M%S)

bin:
ifeq ($(wildcard bin),)
	@mkdir bin
endif
	$(CC) /in $(SRC) /out $(EXEC) /icon $(ICO)

clean:
	rm bin/ pkg/ -r

install: bin
	cp -f $(EXEC) "$(INSTALLDIR)"

package:
ifeq ($(wildcard pkg),)
	@mkdir pkg
endif
	tar -zcvf pkg/PUF_$(BRANCHN).tar.gz src bin tool/Au3Info.exe LICENSE README.md

all: bin package
