UNAME := $(shell uname -s)

ifeq ($(UNAME),Darwin)
    MAKEFILE=Makefile.osx
else
    MAKEFILE=Makefile
endif

all:
	cd src && make -f$(MAKEFILE)
	cp src/silkjs .

bootstrap:
	cd src && make -f$(MAKEFILE) bootstrap
	cp src/bootstrap-silkjs .

install:
	rm -rf /usr/local/silkjs/dependencies/bin
	rm -rf /usr/local/silkjs/dependencies/libexec
	rm -rf /usr/local/silkjs/dependencies/mysql-test
	rm -rf /usr/local/silkjs/dependencies/share
	rm -rf /usr/local/silkjs/dependencies/sql-bench
	mkdir -p /usr/local/silkjs/src
	cp src/*.cpp src/*.h /usr/local/silkjs/src/
	cp -rp builtin /usr/local/silkjs/
	cp -rp modules /usr/local/silkjs/
	cp -rp lib /usr/local/silkjs/
	cp -rp httpd /usr/local/silkjs/
	mkdir -p /usr/local/silkjs/bin/
	cp -p silkjs /usr/local/silkjs/bin/
	cp -p examples/* /usr/local/silkjs/bin
	cp httpd/main.js /usr/local/silkjs/bin/httpd-silk.js
	chmod 775 /usr/local/silkjs/bin/*.js
	chgrp -R admin /usr/local/silkjs
	ln -sf /usr/local/silkjs/bin/siljs /usr/local/bin/silkjs
	ln -sf /usr/local/silkjs/bin/httpd-silk.js /usr/local/bin/httpd-silk.js
	ln -sf /usr/local/silkjs/bin/systat.js /usr/local/bin/systat.js

debug:
	cd src && make -f$(MAKEFILE) debug
	cp src/silkjs .

clean:
	cd src && make -f$(MAKEFILE) clean

realclean:
	cd src && make -f$(MAKEFILE) realclean

