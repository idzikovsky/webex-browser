FIREFOX_URL = https://download-installer.cdn.mozilla.net/pub/firefox/releases/52.4.0esr/linux-i686/en-US/firefox-52.4.0esr.tar.bz2

VERSION = 1
DATETIME = $(shell date +%Y%m%d%H%M)
PREFIX = /opt/webex-browser

dist/webex-browser_$(VERSION)-$(DATETIME).deb : build/firefox/
	mkdir -p dist
	cp -r data/DEBIAN build/
	sed -i "s/__VERSION__/$(VERSION)/g" build/DEBIAN/control
	sed -i "s/__DATETIME__/$(DATETIME)/g" build/DEBIAN/control
	mkdir -p  build/usr/bin/
	cp data/webex-browser build/usr/bin/
	cp data/webex-browser-javaws build/usr/bin/
	mkdir -p build/usr/share/icons/
	cp data/webex-browser.svg build/usr/share/icons/
	mkdir -p build/usr/share/applications/
	cp data/webex-browser.desktop build/usr/share/applications/
	cp data/webex-browser-javaws.desktop build/usr/share/applications/
	dpkg-deb --build build/ dist/webex-browser_$(VERSION)-$(DATETIME).deb

build/firefox/ : dl/firefox-*.tar.bz2 build/jre1.8*
	mkdir -p build/$(PREFIX)/firefox/
	tar -xf dl/firefox-*.tar.bz2 -C build/$(PREFIX)/firefox/ --strip-components=1
	cp data/firefox-conf.js build/$(PREFIX)/firefox/defaults/pref/
	mkdir -p build/$(PREFIX)/firefox/browser/plugins/
	ln -fsr build/$(PREFIX)/jre/lib/i386/libnpjp2.so build/$(PREFIX)/firefox/browser/plugins/

build/jre1.8* : dl/jre-8*.tar.gz
	mkdir -p build/$(PREFIX)/jre/
	tar -xf dl/jre-8*.tar.gz -C build/$(PREFIX)/jre/ --strip-components=1

dl/firefox-*.tar.bz2 :
	mkdir -p dl/
	cd dl/ && curl -O $(FIREFOX_URL)

dl/jre-8*.tar.gz :
	$(error You should download JRE 8 archive from Oracle site to ./dl/ directory manually)

.PHONY: clean
clean:
	rm -rf dl/firefox* build/ dist/
