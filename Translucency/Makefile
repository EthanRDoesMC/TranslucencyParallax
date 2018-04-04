include $(THEOS)/makefiles/common.mk

DEBUG = 0
TWEAK_NAME = TranslucencyParallax

TranslucencyParallax_FILES = Pararelax.xm
TranslucencyParallax_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"

