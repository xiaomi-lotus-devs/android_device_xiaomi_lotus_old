#
# Copyright (C) 2021 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE),lotus)
  subdir_makefiles=$(call first-makefiles-under,$(LOCAL_PATH))
  $(foreach mk,$(subdir_makefiles),$(info including $(mk) ...)$(eval include $(mk)))

include $(CLEAR_VARS)

VENDOR_SYMLINKS := \
    $(TARGET_OUT_VENDOR)/lib/hw \
    $(TARGET_OUT_VENDOR)/lib64/hw

$(VENDOR_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	$(hide) echo "Making vendor symlinks"
	@mkdir -p $(TARGET_OUT_VENDOR)/lib/hw
	@mkdir -p $(TARGET_OUT_VENDOR)/lib64/hw
	@ln -sf libSoftGatekeeper.so $(TARGET_OUT_VENDOR)/lib/hw/gatekeeper.default.so
	@ln -sf libSoftGatekeeper.so $(TARGET_OUT_VENDOR)/lib64/hw/gatekeeper.default.so
	$(hide) touch $@

ALL_DEFAULT_INSTALLED_MODULES += $(VENDOR_SYMLINKS)

LIBGUI_SYMLINK += $(TARGET_OUT_VENDOR)/lib/libgui.so
LIBGUI_SYMLINK += $(TARGET_OUT_VENDOR)/lib64/libgui.so
$(LIBGUI_SYMLINK): $(LOCAL_INSTALLED_MODULE)
	@echo "libgui.so link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf libgui_vendor.so $@
ALL_DEFAULT_INSTALLED_MODULES += $(LIBGUI_SYMLINK)

endif
