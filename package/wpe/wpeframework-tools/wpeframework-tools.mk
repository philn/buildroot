################################################################################
#
# wpeframework-tools
#
################################################################################
HOST_WPEFRAMEWORK_TOOLS_VERSION = f37697444d1f9d6f3acdd7f06506cc234725158e
HOST_WPEFRAMEWORK_TOOLS_SITE = $(call github,rdkcentral,Thunder,$(HOST_WPEFRAMEWORK_TOOLS_VERSION))
HOST_WPEFRAMEWORK_TOOLS_INSTALL_STAGING = YES
HOST_WPEFRAMEWORK_TOOLS_INSTALL_TARGET = NO
HOST_WPEFRAMEWORK_TOOLS_DEPENDENCIES = host-cmake host-python3 host-python3-jsonref
HOST_WPEFRAMEWORK_TOOLS_SUBDIR = Tools

ifeq ($(BR2_CMAKE_HOST_DEPENDENCY),)
HOST_WPEFRAMEWORK_TOOLS_CONF_OPTS += \
	-DGENERIC_CMAKE_MODULE_PATH=$(HOST_DIR)/share/cmake/Modules
endif

$(eval $(host-cmake-package))
