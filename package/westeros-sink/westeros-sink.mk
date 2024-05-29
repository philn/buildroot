################################################################################
#
# westeros-sink
#
################################################################################

WESTEROS_SINK_VERSION = 28fc6542df897c184d247e83972ac952273d8058
WESTEROS_SINK_SITE_METHOD = git
WESTEROS_SINK_SITE = https://code.rdkcentral.com/r/components/opensource/westeros
WESTEROS_SINK_INSTALL_STAGING = YES
WESTEROS_SINK_AUTORECONF = YES
WESTEROS_SINK_AUTORECONF_OPTS = "-Icfg"

WESTEROS_SINK_DEPENDENCIES = host-pkgconf host-autoconf westeros libegl

WESTEROS_SINK_CONF_OPTS += \
	--prefix=/usr/ \
    --disable-silent-rules \
    --disable-dependency-tracking \

ifeq ($(BR2_PACKAGE_RPI_USERLAND),y)
	WESTEROS_SINK_SUBDIR = rpi/westeros-sink
	WESTEROS_SINK_DEPENDENCIES += gstreamer1
	WESTEROS_SINK_CONF_OPTS += --enable-gstreamer1=yes \
                      CFLAGS="$(TARGET_CFLAGS) -DWESTEROS_PLATFORM_RPI -DWESTEROS_INVERTED_Y -DBUILD_WAYLAND -x c++ -I ${STAGING_DIR}/interface/vmcs_host/linux" \
		      CXXFLAGS="$(TARGET_CXXFLAGS) -I ${STAGING_DIR}/interface/vmcs_host/linux"
	
else ifeq ($(BR2_PACKAGE_MARVELL_AMPSDK),y)
	WESTEROS_SINK_CONF_OPTS += --enable-gstreamer1=yes \
			CFLAGS="$(TARGET_CFLAGS) -DLINUX -DEGL_API_FB -I ${STAGING_DIR}/usr/include/marvell/osal/include -I ${STAGING_DIR}/usr/include/marvell/amp/inc -D__LINUX__" \
			CXXFLAGS="$(TARGET_CXXFLAGS) -DLINUX -DEGL_API_FB -I ${STAGING_DIR}/usr/include/marvell/osal/include -I ${STAGING_DIR}/usr/include/marvell/amp/inc -D__LINUX__"
	WESTEROS_SINK_SUBDIR = syna/westeros-sink
else ifeq ($(BR2_PACKAGE_HAS_NEXUS),y)
	WESTEROS_SINK_SUBDIR = brcm/westeros-sink
	WESTEROS_SINK_DEPENDENCIES += gstreamer1
	WESTEROS_SINK_CONF_OPTS += --enable-gstreamer1=yes \
			CFLAGS="$(TARGET_CFLAGS) -I${STAGING_DIR}/usr/include/refsw -I${STAGING_DIR}/usr/include/refsw/bseav" \
			CXXFLAGS="$(TARGET_CXXFLAGS) -I${STAGING_DIR}/usr/include/refsw -I${STAGING_DIR}/usr/include/refsw/bseav"
	WESTEROS_SINK_MAKE_ENV += PKG_CONFIG_SYSROOT_DIR=${STAGING_DIR}
else ifeq ($(BR2_PACKAGE_LIBDRM),y)
	WESTEROS_SINK_SUBDIR = v4l2/westeros-sink
	WESTEROS_SINK_DEPENDENCIES += gstreamer1
	WESTEROS_SINK_CONF_OPTS += --enable-gstreamer1=yes CFLAGS="$(TARGET_CFLAGS) -x c++"
	export STAGING_INCDIR=${STAGING_DIR}/usr/include
endif

define WESTEROS_SINK_RUN_AUTOCONF
	mkdir -p $(@D)/$(WESTEROS_SINK_SUBDIR)/cfg
	mkdir -p $(@D)/$(WESTEROS_SINK_SUBDIR)/m4
endef
WESTEROS_SINK_PRE_CONFIGURE_HOOKS += WESTEROS_SINK_RUN_AUTOCONF

define WESTEROS_SINK_ENTER_BUILD_DIR
	cd $(@D)/$(WESTEROS_SINK_SUBDIR) && ln -sf ../../westeros-sink/westeros-sink.c && ln -sf ../../westeros-sink/westeros-sink.h
endef
WESTEROS_SINK_PRE_BUILD_HOOKS += WESTEROS_SINK_ENTER_BUILD_DIR

$(eval $(autotools-package))
