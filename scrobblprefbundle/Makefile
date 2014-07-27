include theos/makefiles/common.mk


ADDITIONAL_OBJCFLAGS = -fobjc-arc -include scrobblprefbundle-Prefix.pch
export ARCHS = armv7s armv7 arm64
export TARGET = clang:7.0:5.1.1

BUNDLE_NAME = scrobblprefbundle
scrobblprefbundle_FILES = scrobblprefbundle.mm lastFmAuthController.mm SharedPrefs.mm ../FXKeychain/FXKeychain/FXKeychain.m SharedNotificationObserver.m queueController.m subscripting.m
scrobblprefbundle_INSTALL_PATH = /Library/PreferenceBundles
scrobblprefbundle_FRAMEWORKS = UIKit Security
scrobblprefbundle_PRIVATE_FRAMEWORKS = Preferences GraphicsServices
scrobblprefbundle_CODESIGN_FLAGS = -S$(CODESIGN_ENTITLEMENT)
scrobblprefbundle_LIBRARIES = MobileGestalt
export CODESIGN_ENTITLEMENT = ../scrobbled.entitlements
export CODESIGN_COMMANDLINE = $(TARGET_CODESIGN)

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/scrobblprefbundle.plist$(ECHO_END)
