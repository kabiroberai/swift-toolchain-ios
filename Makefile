NULL_NAME := swift-toolchain
SWIFT_VERSION = $(strip $(shell cat toolchains/.version 2>/dev/null | tr -d '\n'))
BUILD = 1

PACKAGE_VERSION = $(SWIFT_VERSION)-$(BUILD)

include $(THEOS)/makefiles/common.mk
include $(THEOS_MAKE_PATH)/null.mk

_THEOS_CONTROL_FILE = $(_THEOS_ESCAPED_STAGING_DIR)/DEBIAN/control
SWIFT_VERSION_DEPENDS = com.modmyi.libswift4 (>= $(SWIFT_VERSION))

ifeq ($(SWIFT_VERSION),)
before-all::
	@$(PRINT_FORMAT_ERROR)"No Swift toolchain found. Please build one using ./prepare-toolchain" >&2; \
	exit 1;
endif

stage::
	$(ECHO_NOTHING)rsync -a toolchains/usr $(THEOS_STAGING_DIR)/ $(_THEOS_RSYNC_EXCLUDE_COMMANDLINE)$(ECHO_END)

before-package::
	$(ECHO_NOTHING)sed -i '' -e 's/\$${SWIFT_VERSION}/$(SWIFT_VERSION_DEPENDS)/g' "$(_THEOS_CONTROL_FILE)"$(ECHO_END)
