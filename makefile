SRC = src/puf.ahk
EXEC = bin/puf.exe
CC = ahkc/Ahk2Exe.exe
ICO = res/puf.ico
BIN = ahkc/AutoHotkeySC.bin
BRANCHN = $(shell hg id -t)-$(shell hg id -b)
EMPTY =

all:
ifeq ($(wildcard bin),)
	@mkdir bin
endif
	$(CC) /in $(SRC) /out $(EXEC) /icon $(ICO) /bin $(BIN)

clean:
	rm bin/ pkg/ -r

install:
	cp bin/puf.exe /

package:
ifeq ($(wildcard pkg),)
	@mkdir pkg
endif
	tar -zcvf pkg/cyg-hotkey-$(BRANCHN).tar.gz bin/cyg-hotkey.exe LICENSE README
