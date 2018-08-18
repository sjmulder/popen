VERSION ?= 1.0alpha

DESTDIR   ?=
PREFIX    ?= /usr/local
MANPREFIX ?= $(PREFIX)/man

CFLAGS += -Wall -Wextra
CFLAGS += -DVERSION=\"$(VERSION)\"

RPMFLAGS += --define "_version $(VERSION)"

all: popen

clean:
	rm -f popen popen-$(VERSION).tar.gz

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

rpm:
	rpmbuild --build-in-place -ba $(RPMFLAGS) popen.spec

.PHONY: all clean install uninstall dist rpm
