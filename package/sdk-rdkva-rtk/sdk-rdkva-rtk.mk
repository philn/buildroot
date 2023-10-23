################################################################################
#
# sdk-rdkva-rtk
#
################################################################################

SDK_RDKVA_RTK_VERSION = eb5940a3e0b630ead43e59dd804f6de5330f3de7
SDK_RDKVA_RTK_SITE = git@github.com:Metrological/SDK_RDKVA_RTK.git
SDK_RDKVA_RTK_SITE_METHOD = git
SDK_RDKVA_RTK_INSTALL_STAGING = YES
SDK_RDKVA_RTK_INSTALL_TARGET = NO

define SDK_RDKVA_RTK_INSTALL_STAGING_CMDS
	cp -r $(@D)/usr/include/* $(STAGING_DIR)/usr/include/
	cp -r $(@D)/usr/lib/* $(STAGING_DIR)/usr/lib/
	cp -r $(@D)/lib/* $(STAGING_DIR)/lib/
endef


$(eval $(generic-package))
