################################################################################
#
# bridge-clients
#
################################################################################

BRIDGE_CLIENTS_VERSION = trunk
BRIDGE_CLIENTS_SITE_METHOD = git
BRIDGE_CLIENTS_SITE = git@git.integraal.info:Integraal/clients
BRIDGE_CLIENTS_INSTALL_STAGING = YES
BRIDGE_CLIENTS_INSTALL_TARGET = YES

BRIDGE_CLIENTS_DEPENDENCIES = bridge bridge-contracts

BRIDGE_CLIENTS_SUBDIR = src

ifeq ($(BR2_PACKAGE_BRIDGE_VIRTUALINPUT),y)
    BRIDGE_CLIENTS_CONF_OPTS += -DVIRTUALINPUT=ON
endif

ifeq ($(BR2_PACKAGE_BRIDGE_COMPOSITORCLIENT),y)
    BRIDGE_CLIENTS_CONF_OPTS += -DCOMPOSITORCLIENT=ON
    ifeq ($(BR2_PACKAGE_WESTEROS),y)
        BRIDGE_CLIENTS_CONF_OPTS += -DPLUGIN_COMPOSITOR_IMPLEMENTATION=Wayland
        BRIDGE_CLIENTS_DEPENDENCIES += westeros
    else ifeq ($(BR2_PACKAGE_HAS_NEXUS),y)
        BRIDGE_CLIENTS_DEPENDENCIES += bcm-refsw
        BRIDGE_CLIENTS_CONF_OPTS += -DPLUGIN_COMPOSITOR_IMPLEMENTATION=Nexus
    else ifeq  ($(BR2_PACKAGE_RPI_FIRMWARE),y)
        BRIDGE_CLIENTS_DEPENDENCIES += rpi-userland
        BRIDGE_CLIENTS_CONF_OPTS += -DPLUGIN_COMPOSITOR_IMPLEMENTATION=RPI
    else
        $(error Missing a compositor implemtation, please provide one or disable PLUGIN_COMPOSITOR)
    endif
endif

ifeq ($(BR2_PACKAGE_BRIDGE_OPENCDM),y)
    BRIDGE_CLIENTS_CONF_OPTS += -DCDMI_ADAPTER_IMPLEMENTATION=gstreamer
    BRIDGE_CLIENTS_CONF_OPTS += -DCDMI=ON
    BRIDGE_CLIENTS_DEPENDENCIES += gstreamer1
endif

ifeq ($(BR2_PACKAGE_BRIDGE_PROVISIONPROXY),y)
    BRIDGE_CLIENTS_CONF_OPTS += -DPROVISIONPROXY=ON
    BRIDGE_CLIENTS_DEPENDENCIES += libprovision
endif

$(eval $(cmake-package))
