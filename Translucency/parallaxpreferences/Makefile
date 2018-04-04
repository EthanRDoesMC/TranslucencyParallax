include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = ParallaxPreferences
ParallaxPreferences_FILES = TPLXRootListController.m
ParallaxPreferences_INSTALL_PATH = /Library/PreferenceBundles
ParallaxPreferences_FRAMEWORKS = UIKit
ParallaxPreferences_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/ParallaxPreferences.plist$(ECHO_END)
