################################################################################
#
# wpeframework-amazon
#
################################################################################

WPEFRAMEWORK_AMAZON_VERSION = 2ae9e80e8f86435a6e808cd05642db44d5e18e63
WPEFRAMEWORK_AMAZON_SITE_METHOD = git
WPEFRAMEWORK_AMAZON_SITE = git@github.com:Metrological/WPEPluginAmazon.git
WPEFRAMEWORK_AMAZON_INSTALL_STAGING = YES
WPEFRAMEWORK_AMAZON_DEPENDENCIES = wpeframework amazon-ignition

WPEFRAMEWORK_AMAZON_SUPPORTS_IN_SOURCE_BUILD = NO

WPEFRAMEWORK_AMAZON_CONF_OPTS += -DBUILD_REFERENCE=${WPEFRAMEWORK_AMAZON_VERSION}

ifeq ($(BR2_CMAKE_HOST_DEPENDENCY),)
WPEFRAMEWORK_AMAZON_CONF_OPTS += -DCMAKE_MODULE_PATH=$(HOST_DIR)/share/cmake/Modules
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_AMAZON_AUTOSTART),y)
WPEFRAMEWORK_AMAZON_CONF_OPTS += -DPLUGIN_AMAZON_PRIME_AUTOSTART=ON
endif

ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_AMAZON_INSTALL_PATH_OVERRIDE),"")
WPEFRAMEWORK_AMAZON_CONF_OPTS += -DPLUGIN_AMAZON_PRIME_INSTALL_PATH=${BR2_PACKAGE_WPEFRAMEWORK_AMAZON_INSTALL_PATH_OVERRIDE}
WPEFRAMEWORK_AMAZON_DATA_PATH = ${BR2_PACKAGE_WPEFRAMEWORK_AMAZON_INSTALL_PATH_OVERRIDE}
else
WPEFRAMEWORK_AMAZON_CONF_OPTS += -DPLUGIN_AMAZON_PRIME_INSTALL_PATH=${BR2_PACKAGE_AMAZON_IGNITION_IG_INSTALL_PATH}
WPEFRAMEWORK_AMAZON_DATA_PATH = ${BR2_PACKAGE_AMAZON_IGNITION_IG_INSTALL_PATH}
endif

ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_AMAZON_DTID),"")
WPEFRAMEWORK_AMAZON_CONF_OPTS +=-DPLUGIN_AMAZON_PRIME_DTID=$(BR2_PACKAGE_WPEFRAMEWORK_AMAZON_DTID)
endif

ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_AMAZON_MANUFACTURER),"")
WPEFRAMEWORK_AMAZON_CONF_OPTS += -DPLUGIN_AMAZON_PRIME_MANUFACTURER=$(BR2_PACKAGE_WPEFRAMEWORK_AMAZON_MANUFACTURER)
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_AMAZON_MODEL),"")
WPEFRAMEWORK_AMAZON_CONF_OPTS += -DPLUGIN_AMAZON_PRIME_MODEL_NAME=$(BR2_PACKAGE_WPEFRAMEWORK_AMAZON_MODEL)
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_AMAZON_CHIPSET),"")
WPEFRAMEWORK_AMAZON_CONF_OPTS += -DPLUGIN_AMAZON_PRIME_CHIPSET_NAME=$(BR2_PACKAGE_WPEFRAMEWORK_AMAZON_CHIPSET)
endif

ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_AMAZON_USER),"")
WPEFRAMEWORK_AMAZON_CONF_OPTS += -DPLUGIN_AMAZON_PRIME_NAME=$(BR2_PACKAGE_WPEFRAMEWORK_AMAZON_USER)
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_AMAZON_GROUP),"")
WPEFRAMEWORK_AMAZON_USER_GROUP=amazon
else
WPEFRAMEWORK_AMAZON_USER_GROUP=$(subst ",,$(BR2_PACKAGE_WPEFRAMEWORK_AMAZON_GROUP)")
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_CDMI_GROUP),"")
WPEFRAMEWORK_CDMI_GROUP=,$(subst ",,$(BR2_PACKAGE_WPEFRAMEWORK_CDMI_GROUP)")
endif
WPEFRAMEWORK_AMAZON_USER=$(subst ",,$(BR2_PACKAGE_WPEFRAMEWORK_AMAZON_USER)") -1 $(WPEFRAMEWORK_AMAZON_USER_GROUP) -1 * - - $(subst ",,$(BR2_PACKAGE_WPEFRAMEWORK_PLATFORM_VIDEO_DEVICE_GROUP)"),$(subst ",,$(BR2_PACKAGE_WPEFRAMEWORK_GROUP)")$(WPEFRAMEWORK_CDMI_GROUP) amazon
WPEFRAMEWORK_AMAZON_PERMISSION=$(subst ",,$(WPEFRAMEWORK_AMAZON_DATA_PATH)") r 0550 root $(subst ",,$(WPEFRAMEWORK_AMAZON_USER_GROUP)") - - - - -
endif

ifneq ($(WPEFRAMEWORK_AMAZON_USER_GROUP),"")
WPEFRAMEWORK_AMAZON_CONF_OPTS += -DPLUGIN_AMAZON_PRIME_GROUP=$(WPEFRAMEWORK_AMAZON_USER_GROUP)
endif

ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_AMAZON_CA_BUNDLE_PATH),"")
WPEFRAMEWORK_AMAZON_CONF_OPTS += -DPLUGIN_AMAZON_PRIME_CA_BUNDLE_PATH=$(BR2_PACKAGE_WPEFRAMEWORK_AMAZON_CA_BUNDLE_PATH)
endif

ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_AMAZON_FRAGMENT_CACHE_SIZE),"")
WPEFRAMEWORK_AMAZON_CONF_OPTS += -DPLUGIN_AMAZON_PRIME_FRAGMENT_CACHE_SIZE=$(BR2_PACKAGE_WPEFRAMEWORK_AMAZON_FRAGMENT_CACHE_SIZE)
endif

ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_AMAZON_LOG_LEVEL),"")
WPEFRAMEWORK_AMAZON_CONF_OPTS += -DPLUGIN_AMAZON_PRIME_LOG_LEVEL=$(BR2_PACKAGE_WPEFRAMEWORK_AMAZON_LOG_LEVEL)
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_DEBUG),y)
WPEFRAMEWORK_AMAZON_CONF_OPTS += -DCMAKE_BUILD_TYPE=Debug
endif

define WPEFRAMEWORK_AMAZON_USERS
	${WPEFRAMEWORK_AMAZON_USER}
endef

define WPEFRAMEWORK_AMAZON_PERMISSIONS
	${WPEFRAMEWORK_AMAZON_PERMISSION}
endef

$(eval $(cmake-package))
