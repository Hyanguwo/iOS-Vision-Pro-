ARCHS = arm64 arm64e
TARGET = iphone:clang:13.7:13.0
INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = VisionProPopup

VisionProPopup_FILES = Tweak.xm
VisionProPopup_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
    install.exec "killall -9 SpringBoard"
