################################################################################
#
# WPEWebKit
#
################################################################################

ifeq ($(BR2_PACKAGE_WPEWEBKIT2_22),y)
WPEWEBKIT_VERSION = 2.22
WPEWEBKIT_VERSION_VALUE = fdd0de84bb678cbc781d583ca06e4f9464f5a519
endif

ifeq ($(BR2_PACKAGE_WPEWEBKIT2_28),y)
# This is the wpe-2.28-soup3 branch tip.
WPEWEBKIT_VERSION = 2.28
WPEWEBKIT_VERSION_VALUE = a84ae70f17ce31f8bc304917fe81c0a97fc47f8a
endif

WPEWEBKIT_SITE = $(call github,WebPlatformForEmbedded,WPEWebKit,$(WPEWEBKIT_VERSION_VALUE))
WPEWEBKIT_INSTALL_STAGING = YES
WPEWEBKIT_LICENSE = LGPL-2.1+, BSD-2-Clause
WPEWEBKIT_LICENSE_FILES = \
	Source/WebCore/LICENSE-APPLE \
	Source/WebCore/LICENSE-LGPL-2.1

WPEWEBKIT_DEPENDENCIES = host-gperf host-python host-ruby \
	libgles wpebackend libepoxy cairo jpeg libpng harfbuzz icu webp libsoup \
	libgcrypt libxslt openjpeg

ifeq ($(BR2_PACKAGE_WPEWEBKIT2_22),y)

WPEWEBKIT_EXTRA_FLAGS = -DCMAKE_EXPORT_COMPILE_COMMANDS=ON

WPEWEBKIT_FLAGS = \
	-DPORT=WPE \
	-DEXPORT_DEPRECATED_WEBKIT2_C_API=ON \
	-DENABLE_ACCELERATED_2D_CANVAS=ON \
	-DENABLE_GEOLOCATION=OFF \
	-DENABLE_DEVICE_ORIENTATION=OFF \
	-DENABLE_GAMEPAD=OFF \
	-DENABLE_SUBTLE_CRYPTO=OFF \
	-DENABLE_FULLSCREEN_API=OFF \
	-DENABLE_NOTIFICATIONS=OFF \
	-DENABLE_DATABASE_PROCESS=OFF \
	-DENABLE_INDEXED_DATABASE=OFF \
	-DENABLE_MEDIA_STATISTICS=OFF \
	-DENABLE_FETCH_API=OFF \
	-DENABLE_WEBDRIVER=ON \
	-DENABLE_SAMPLING_PROFILER=ON \
	-DENABLE_TOUCH_EVENTS=OFF \
	-DENABLE_FTL_JIT=OFF \
	-DENABLE_MATHML=OFF \
	-DENABLE_METER_ELEMENT=OFF \
	-DENABLE_SVG_FONTS=OFF \
	-DENABLE_WEBASSEMBLY=OFF




WPEWEBKIT_DEPENDENCIES += gstreamer1 gst1-plugins-base \
	gst1-plugins-good gst1-plugins-bad
WPEWEBKIT_FLAGS += \
	-DENABLE_VIDEO=ON \
	-DENABLE_VIDEO_TRACK=ON

ifeq ($(BR2_PACKAGE_WPEWEBKIT_ENABLE_NATIVE_VIDEO),y)
WPEWEBKIT_FLAGS += -DENABLE_NATIVE_VIDEO=ON
else
WPEWEBKIT_FLAGS += -DENABLE_NATIVE_VIDEO=OFF
endif

ifeq ($(BR2_PACKAGE_WPEWEBKIT_ENABLE_NATIVE_AUDIO),y)
WPEWEBKIT_FLAGS += -DENABLE_NATIVE_AUDIO=ON
else
WPEWEBKIT_FLAGS += -DENABLE_NATIVE_AUDIO=OFF
endif

ifeq ($(BR2_PACKAGE_WPEWEBKIT_ENABLE_TEXT_SINK),y)
WPEWEBKIT_FLAGS += -DENABLE_TEXT_SINK=ON
else
WPEWEBKIT_FLAGS += -DENABLE_TEXT_SINK=OFF
endif

ifeq ($(BR2_PACKAGE_WPEWEBKIT_USE_WEB_AUDIO),y)
WPEWEBKIT_FLAGS += -DENABLE_WEB_AUDIO=ON
else
WPEWEBKIT_FLAGS += -DENABLE_WEB_AUDIO=OFF
endif

ifeq ($(BR2_PACKAGE_WPEWEBKIT_ENABLE_MEDIA_SOURCE),y)
WPEWEBKIT_FLAGS += -DENABLE_MEDIA_SOURCE=ON
else
WPEWEBKIT_FLAGS += -DENABLE_MEDIA_SOURCE=OFF
endif

ifeq ($(BR2_PACKAGE_WPEWEBKIT_USE_ENCRYPTED_MEDIA),y)
WPEWEBKIT_FLAGS += -DENABLE_ENCRYPTED_MEDIA=ON
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_CDM),y)
WPEWEBKIT_DEPENDENCIES += wpeframework-clientlibraries
WPEWEBKIT_FLAGS += -DENABLE_OPENCDM=ON
endif

ifeq ($(BR2_PACKAGE_WPEWEBKIT_USE_GSTREAMER_GL),y)
WPEWEBKIT_FLAGS += -DUSE_GSTREAMER_GL=ON
else
WPEWEBKIT_FLAGS += -DUSE_GSTREAMER_GL=OFF
endif

ifeq ($(BR2_PACKAGE_WPEWEBKIT_USE_GSTREAMER_WEBKIT_HTTP_SRC),y)
WPEWEBKIT_FLAGS += -DUSE_GSTREAMER_WEBKIT_HTTP_SRC=ON
else
WPEWEBKIT_FLAGS += -DUSE_GSTREAMER_WEBKIT_HTTP_SRC=OFF
endif

endif

ifeq ($(BR2_PACKAGE_WPEWEBKIT2_28),y)

WPEWEBKIT_FLAGS = \
	-DPORT=WPE \
	-DENABLE_ACCESSIBILITY=OFF \
	-DENABLE_API_TESTS=OFF \
	-DENABLE_MINIBROWSER=OFF \
	-DSILENCE_CROSS_COMPILATION_NOTICES=ON \
	-DENABLE_BUBBLEWRAP_SANDBOX=OFF \
	-DENABLE_ACCELERATED_2D_CANVAS=ON \
	-DUSE_WOFF2=OFF

ifeq ($(BR2_PACKAGE_WPEWEBKIT_MULTIMEDIA),y)
WPEWEBKIT_FLAGS += \
	-DENABLE_VIDEO=ON \
	-DENABLE_MEDIA_SOURCE=ON \
	-DENABLE_ENCRYPTED_MEDIA=ON \
	-DENABLE_MEDIA_STATISTICS=ON \
	-DENABLE_THUNDER=ON \
	-DENABLE_WEB_AUDIO=ON
WPEWEBKIT_DEPENDENCIES += gstreamer1 gst1-plugins-base gst1-plugins-good
else
WPEWEBKIT_FLAGS += \
	-DENABLE_VIDEO=OFF \
	-DENABLE_MEDIA_SOURCE=OFF \
	-DENABLE_ENCRYPTED_MEDIA=OFF \
	-DENABLE_THUNDER=OFF \
	-DENABLE_WEB_AUDIO=OFF
endif

ifeq ($(BR2_PACKAGE_WPEWEBKIT_USE_GSTREAMER_GL),y)
WPEWEBKIT_FLAGS += -DUSE_GSTREAMER_GL=ON
else
WPEWEBKIT_FLAGS += -DUSE_GSTREAMER_GL=OFF
endif

ifeq ($(BR2_PACKAGE_WPEWEBKIT_WEBDRIVER),y)
WPEWEBKIT_FLAGS += -DENABLE_WEBDRIVER=ON
else
WPEWEBKIT_FLAGS += -DENABLE_WEBDRIVER=OFF
endif

endif

ifeq ($(BR2_PACKAGE_WPEWEBKIT_DEBUG)$(BR2_PACKAGE_WPEWEBKIT_SYMBOLS),y)
WPEWEBKIT_SYMBOL_FLAGS = -g
endif

WPEWEBKIT_BUILD_TYPE = Release
WPEWEBKIT_CXXFLAGS = -O2 -DNDEBUG
ifeq ($(BR2_PACKAGE_WPEWEBKIT_DEBUG),y)
WPEWEBKIT_BUILD_TYPE = Debug
WPEWEBKIT_FLAGS += -DCMAKE_BUILD_TYPE=Debug
WPEWEBKIT_CXXFLAGS = -O0
endif

WEBKIT_COMPILER_FLAGS=$(WPEWEBKIT_SYMBOL_FLAGS) $(WPEWEBKIT_CXXFLAGS) -Wno-cast-align
WPEWEBKIT_EXTRA_FLAGS += \
	-DCMAKE_C_FLAGS_RELEASE="$(WEBKIT_COMPILER_FLAGS)" \
	-DCMAKE_CXX_FLAGS_RELEASE="$(WEBKIT_COMPILER_FLAGS)" \
	-DCMAKE_C_FLAGS_DEBUG="$(WEBKIT_COMPILER_FLAGS)" \
	-DCMAKE_CXX_FLAGS_DEBUG="$(WEBKIT_COMPILER_FLAGS)"

ifeq ($(BR2_PACKAGE_WPEWEBKIT_USE_PUNCH_HOLE_GSTREAMER),y)
WPEWEBKIT_FLAGS += -DUSE_HOLE_PUNCH_GSTREAMER=ON -DUSE_GSTREAMER_HOLEPUNCH=ON
else ifeq ($(BR2_PACKAGE_WPEWEBKIT_USE_PUNCH_HOLE_EXTERNAL),y)
WPEWEBKIT_FLAGS += -DUSE_HOLE_PUNCH_EXTERNAL=ON -DUSE_EXTERNAL_HOLEPUNCH=ON
endif

ifeq ($(BR2_PACKAGE_WESTEROS),y)
WPEWEBKIT_DEPENDENCIES += westeros
WPEWEBKIT_FLAGS += -DUSE_WPEWEBKIT_PLATFORM_WESTEROS=ON
ifeq ($(BR2_PACKAGE_WESTEROS_SINK),y)
WPEWEBKIT_DEPENDENCIES += westeros-sink
WPEWEBKIT_FLAGS += -DUSE_WESTEROS_SINK=ON -DUSE_HOLE_PUNCH_GSTREAMER=ON -DUSE_GSTREAMER_HOLEPUNCH=ON
else
WPEWEBKIT_FLAGS += -DUSE_HOLE_PUNCH_GSTREAMER=OFF -DUSE_GSTREAMER_HOLEPUNCH=OFF
endif
else ifeq ($(BR2_PACKAGE_HAS_NEXUS),y)
WPEWEBKIT_FLAGS += -DUSE_WPEWEBKIT_PLATFORM_BCM_NEXUS=ON
else ifeq ($(BR2_PACKAGE_HORIZON_SDK),y)
WPEWEBKIT_FLAGS += -DUSE_WPEWEBKIT_PLATFORM_INTEL_CE=ON
else ifeq ($(BR2_PACKAGE_INTELCE_SDK),y)
WPEWEBKIT_FLAGS += -DUSE_WPEWEBKIT_PLATFORM_INTEL_CE=ON
else ifeq ($(BR2_PACKAGE_RPI_FIRMWARE),y)
WPEWEBKIT_FLAGS += -DUSE_WPEWEBKIT_PLATFORM_RPI=ON
endif

WPEWEBKIT_CONF_OPTS = \
	$(WPEWEBKIT_EXTRA_FLAGS) \
	$(WPEWEBKIT_FLAGS)

$(eval $(cmake-package))
