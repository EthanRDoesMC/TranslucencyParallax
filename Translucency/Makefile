DEBUG = 0


TARGET = simulator:clang::11.1
TARGET_CODESIGN_FLAGS = -SEntitlements.xml

ARCHS = x86_64

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = TranslucencyParallax
TranslucencyParallax_FILES = Pararelax.xm

TranslucencyParallax_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"

