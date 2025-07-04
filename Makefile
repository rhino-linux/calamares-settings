PREFIX = /etc/calamares

all: install

install:
	install -d $(DESTDIR)$(PREFIX)/modules
	install -m644 settings.conf $(DESTDIR)$(PREFIX)/
	install -m644 modules/*.conf $(DESTDIR)$(PREFIX)/modules/

.PHONY: all install
