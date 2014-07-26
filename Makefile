VERSION = 1.0.0

all: prefbundle daemon daemon-deb

prefbundle: check-theos check-build-dir
	cd scrobblprefbundle && rm -rf *.deb ./_/ && make package
	cp -r scrobblprefbundle/_/Library/ ./Build/scrobbled/Library/

daemon: check-build-dir
	xcodebuild -workspace scrobbled.xcworkspace/ -scheme scrobbled CONFIGURATION_BUILD_DIR="./Build" -configuration "Release"
	rm -rf ./Build/Intermediates ./Build/Products

check-theos:
	if test "$(THEOS)" = "" ; then \
        echo "Please set THEOS environment variable."; \
        exit 1; \
    fi

check-build-dir:
	rm -rf ./Build/
	mkdir -p Build/scrobbled/

check-dpkg:
	command -v dpkg-deb >/dev/null 2>&1 || { echo >&2 "Need dpkg to build a deb, aborting"; exit 1; }

daemon-deb: check-dpkg
	mkdir -p ./Build/scrobbled/DEBIAN ./Build/scrobbled/System/Library/LaunchDaemons/ \
		./Build/scrobbled/Applications/scrobble.app/

	cp ./debian/control ./Build/scrobbled/DEBIAN/control
	echo "Version: $(VERSION)" >> ./Build/scrobbled/DEBIAN/control

	mv ./Build/scrobbled.app/org.nodomain.scrobbled.plist ./Build/scrobbled/System/Library/LaunchDaemons
	mv ./Build/scrobbled.app/* ./Build/scrobbled/Applications/scrobble.app/
	cp ./debian/postinst ./Build/scrobbled/DEBIAN/
	cp ./debian/prerm ./Build/scrobbled/DEBIAN/
	chmod 0755 ./Build/scrobbled/DEBIAN/ ./Build/scrobbled/DEBIAN/*
	export COPY_EXTENDED_ATTRIBUTES_DISABLE=1

	cd ./Build && dpkg-deb -Zgzip -b scrobbled scrobbl_$(VERSION).deb
