## Scrobbl

Scrobbl is a Last.fm scrobbling daemon for (jailbroken) iOS.

This is a rewrite of the [original](http://moreinfo.thebigboss.org/moreinfo/depiction.php?file=scrobblData) daemon with numerous improvements and fixes.

#### [Get latest build (.deb)](https://github.com/comscandiumplumbumd/scrobbl/tree/master/Build)

### iOS version support

Scrobbl requires at least iOS 5.0.

By default, this daemon deploys for 5.1.1 as it is required to run applications with arm64 slice. If you want to build for an earlier version of iOS, remove arm64 from the build architectures in ```scrobblprefbundle/Makefile```  and ```Scrobbbled.xcworkspace```.

Please note that the daemon won't function on iOS versions prior to 5.0 as the ```MediaRemote.framework``` it relies on to get track info is not yet present.


### Caveats

- ```MediaRemote.framework``` present in iOS 5 provides no information about track duration for tracks played from third-party applications. Scrobbl waits 30 seconds to check if the track is still being played and scrobbles it if it is. If you find this delay too short, please adjust variable ```delay``` in ```PBMediaRemoteNotificationObserver.m```.
- Scrobbl uses ```apple``` [Keychain Access Group](https://developer.apple.com/library/ios/documentation/security/Reference/keychainservices/Reference/reference.html#jumpTo_55). This is needed for the daemon to be able to access credentials set from Preferences.app; otherwise we'd have to resort to adding an Acess Group to Preferences.app, which is a bad idea. In future, this might be solved by implementing Last.fm OAuth support.

### Building

Clone the repo and run ```git submodule update --init --recursive```.

Create ```/Classes/apikey.h``` and ```#define``` there your Last.fm API keys like this:

    #define kLFAPIKey @"YOURAPIKEY"
    #define kLFAPISecret @"YOURAPISECRET"

Use the makefile to build the project. If you need to, adjust ```VERSION``` variable.
