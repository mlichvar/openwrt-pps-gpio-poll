#
# Copyright (C) 2017 Miroslav Lichvar <mlichvar0@gmail.com>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=pps-poll-gpio
PKG_VERSION=0.1.$(PKG_SOURCE_VERSION)
PKG_RELEASE:=1

PKG_SOURCE=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=https://github.com/mlichvar/pps-gpio-poll.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE_SUBDIR=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=2b62adc5e6d7f742f8d4fbfaf75cdaeb26fb6430

PKG_MAINTAINER:=Miroslav Lichvar <mlichvar0@gmail.com>
PKG_LICENSE:=GPL-2.0
#PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk

define KernelPackage/pps-gpio-poll
	SUBMENU:=Other modules
	TITLE:=PPS GPIO polling driver
	FILES:=$(PKG_BUILD_DIR)/pps-gpio-poll.ko
	DEPENDS:=+kmod-pps
endef

define KernelPackage/pps-gpio-poll/description
	Kernel module for polling PPS GPIO driver
endef

MAKE_OPTS:= \
	ARCH="$(LINUX_KARCH)" \
	CROSS_COMPILE="$(TARGET_CROSS)" \
	M="$(PKG_BUILD_DIR)"

define Build/Compile
	$(MAKE) -C "$(LINUX_DIR)" \
		$(MAKE_OPTS) \
		modules
endef

$(eval $(call KernelPackage,pps-gpio-poll))
