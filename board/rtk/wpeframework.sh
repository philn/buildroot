#!/bin/sh

export SOURCE=/tmp/data/rtk
export LD_LIBRARY_PATH=$SOURCE/usr/lib:$SOURCE/lib:/lib:/usr/lib:/usr/lib/realtek:$SOURCE/usr/lib/wpeframework/plugins:$SOURCE/usr/lib/wpeframework/proxystubs:$SOURCE/usr/lib/wpe-webkit-1.0:$SOURCE/usr/lib/wpe-webkit-1.1
export LD_PRELOAD=/usr/lib/libwayland-client.so.0:/usr/lib/realtek/libVOutWrapper.so:/usr/lib/realtek/libjpu.so:/usr/lib/realtek/libvpu.so:/usr/lib/libwesteros_gl.so.0
export PATH=$SOURCE/usr/bin:$PATH
export GST_PLUGIN_SCANNER=$GST_PLUGIN_SCANNER:$SOURCE/usr/libexec/gstreamer-1.0/gst-plugin-scanner
export GST_PLUGIN_SYSTEM_PATH=$GST_PLUGIN_SYSTEM_PATH:$SOURCE/usr/lib/gstreamer-1.0

export WAYLAND_DISPLAY=wayland-0
export XDG_RUNTIME_DIR=/tmp
export XDG_DATA_HOME=/opt/QT/home
export RDKSHELL_SHOW_SPLASH_TIME_IN_SECONDS=30
export RDKSHELL_SPLASH_IMAGE_JPEG=
export RDKSHELL_SHOW_SPLASH_SCREEN=1
export FORCE_SVP=TRUE
export RDKSHELL_FRAMERATE=60

export RDKSHELL_STARTUP_CONFIG=/etc/rdkshell_post_startup.conf
export WESTEROS_SINK_USE_ESSRMGR=0

if [ ! -f /usr/lib/libEGL.so.1 ]; then
        ln -s /usr/lib/libEGL.so /usr/lib/libEGL.so.1
fi

if [ ! -f /usr/lib/libGLESv2.so.2 ]; then
        ln -s /usr/lib/libGLESv2.so /usr/lib/libGLESv2.so.2
fi

if [ ! -f /usr/lib/libwesteros_render_gl.so ]; then
        ln -s /usr/lib/libwesteros_render_gl.so.0 /usr/lib/libwesteros_render_gl.so
fi

if [ ! -d /usr/libexec/wpe-webkit-1.0 ]; then
	ln -s $SOURCE/usr/libexec/wpe-webkit-1.0 /usr/libexec/wpe-webkit-1.0
fi
if [ ! -d /usr/lib/wpe-webkit-1.0 ]; then
	ln -s $SOURCE/usr/lib/wpe-webkit-1.0 /usr/lib/wpe-webkit-1.0
fi

if [ ! -d /usr/libexec/wpe-webkit-1.1 ]; then
        ln -s $SOURCE/usr/libexec/wpe-webkit-1.1 /usr/libexec/wpe-webkit-1.1
fi
if [ ! -d /usr/lib/wpe-webkit-1.1 ]; then
        ln -s $SOURCE/usr/lib/wpe-webkit-1.1 /usr/lib/wpe-webkit-1.1
fi

cd /usr/bin/
$SOURCE/usr/bin/WPEFramework -c $SOURCE/etc/WPEFramework/config.json &
