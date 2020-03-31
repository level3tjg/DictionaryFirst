THEOS_DEVICE_IP = 192.168.1.65
ARCHS = arm64 arm64e
INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = DictionaryFirst

DictionaryFirst_FILES = Tweak.x
DictionaryFirst_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += postinst
include $(THEOS_MAKE_PATH)/aggregate.mk
