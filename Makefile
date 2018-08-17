DESTDIR   ?=
PREFIX    ?= /usr/local
MANPREFIX ?= $(PREFIX)/man

CFLAGS += -Wall -Wextra

all: popen

clean:
	rm -f popen

install: popen
	install -d $(DESTDIR)$(PREFIX)/bin
	install -d $(DESTDIR)$(MANPREFIX)/man1
	install popen   $(DESTDIR)$(PREFIX)/bin/
	install popen.1 $(DESTDIR)$(MANPREFIX)/man1/

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/popen
	rm -f $(DESTDIR)$(MANPREFIX)/man1/popen.1
	-rmdir -p $(DESTDIR)$(PREFIX)/bin
	-rmdir -p $(DESTDIR)$(MANPREFIX)/man1

.PHONY: all clean install uninstall
