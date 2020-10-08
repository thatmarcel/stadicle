include $(THEOS)/makefiles/common.mk

TWEAK_NAME = StadicleTweak

$(TWEAK_NAME)_FILES = Tweak.xm GamepadSupport.m WebViewScriptMessageHandler.m
$(TWEAK_NAME)_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "sbreload"
