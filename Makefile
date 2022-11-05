NULL_NAME := swift-toolchain
SWIFT_VERSION := $(shell cat toolchains/.version 2>/dev/null)
BUILD := 1

override PACKAGE_VERSION := $(SWIFT_VERSION)-$(BUILD)

include $(THEOS)/makefiles/common.mk
include $(THEOS_MAKE_PATH)/null.mk

_THEOS_CONTROL_FILE = $(THEOS_STAGING_DIR)/DEBIAN/control
SWIFT_VERSION_DEPENDS = org.swift.libswift (>= $(SWIFT_VERSION))

ifeq ($(SWIFT_VERSION),)
before-all::
	@$(PRINT_FORMAT_ERROR)"No Swift toolchain found. Please build one using ./prepare-toolchain" >&2; \
	exit 1;
endif

stage::
	$(ECHO_NOTHING)rsync -a toolchains/usr-$(SWIFT_VERSION)/ $(THEOS_STAGING_DIR)/usr $(_THEOS_RSYNC_EXCLUDE_COMMANDLINE)$(ECHO_END)

clean::
	$(ECHO_NOTHING)rm -rf toolchains/swift-source/build$(ECHO_END)

before-package::
	$(ECHO_NOTHING)sed -i '' -e 's/\$${SWIFT_VERSION}/$(SWIFT_VERSION_DEPENDS)/g' "$(_THEOS_CONTROL_FILE)"$(ECHO_END)
