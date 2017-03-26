LOCAL_PATH:= $(call my-dir)

S:=dist/src/libudev

libudev_common_src_files := \
 $(S)/libudev-device-private.c \
 $(S)/libudev-device.c \
 $(S)/libudev-enumerate.c \
 $(S)/libudev-hwdb.c \
 $(S)/libudev-list.c \
 $(S)/libudev-monitor.c \
 $(S)/libudev-queue-private.c \
 $(S)/libudev-queue.c \
 $(S)/libudev-util.c \
 $(S)/libudev.c \
 $(S)/../shared/conf-files.c \
 $(S)/../shared/dev-setup.c \
 $(S)/../shared/env-util.c \
 $(S)/../shared/fileio.c \
 $(S)/../shared/hashmap.c \
 $(S)/../shared/exit-status.c \
 $(S)/../shared/label.c \
 $(S)/../shared/mkdir.c \
 $(S)/../shared/path-util.c \
 $(S)/../shared/set.c \
 $(S)/../shared/strbuf.c \
 $(S)/../shared/strv.c \
 $(S)/../shared/strxcpyx.c \
 $(S)/../shared/time-util.c \
 $(S)/../shared/utf8.c \
 $(S)/../shared/util.c \
 android/glob.c \
 android/log.c \
 android/missing.c

libudev_common_c_includes := \
 $(LOCAL_PATH)/include \
 $(LOCAL_PATH)/android \
 $(LOCAL_PATH)/dist/src/shared \
 $(LOCAL_PATH)/dist/src/systemd \

libudev_common_c_flags := \
 -Wno-missing-field-initializers \
 -Wno-unknown-attributes \
 -std=gnu99 \
 -include $(LOCAL_PATH)/android/udev.h

### libudev.so

include $(CLEAR_VARS)

S:=dist/src/libudev

LOCAL_SRC_FILES:= \
 $(libudev_common_src_files)

LOCAL_C_INCLUDES += \
 $(libudev_common_c_includes)

LOCAL_CFLAGS += \
 $(libudev_common_c_flags)

LOCAL_SHARED_LIBRARIES += libcutils

LOCAL_LDLIBS := -llog

LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)/include
LOCAL_MODULE:= libudev
LOCAL_MODULE_TAGS := optional
LOCAL_PRELINK_MODULE:= false

include $(BUILD_SHARED_LIBRARY)

### libudev.a

include $(CLEAR_VARS)

S:=dist/src/libudev

LOCAL_SRC_FILES:= \
 $(libudev_common_src_files)

LOCAL_C_INCLUDES += \
 $(libudev_common_c_includes)

LOCAL_CFLAGS += \
 $(libudev_common_c_flags)

LOCAL_MODULE:= libudev
LOCAL_MODULE_TAGS := optional
LOCAL_PRELINK_MODULE:= false

include $(BUILD_STATIC_LIBRARY)

### udevadm

include $(CLEAR_VARS)

S:=dist/src/udev

LOCAL_SRC_FILES:= \
 $(S)/udev-ctrl.c \
 $(S)/udev-builtin.c \
 $(S)/udev-builtin-btrfs.c \
 $(S)/udev-builtin-hwdb.c \
 $(S)/udev-builtin-input_id.c \
 $(S)/udev-builtin-keyboard.c \
 $(S)/udev-builtin-net_id.c \
 $(S)/udev-builtin-path_id.c \
 $(S)/udev-builtin-usb_id.c \
 $(S)/udev-event.c \
 $(S)/udev-node.c \
 $(S)/udev-rules.c \
 $(S)/udev-watch.c \
 $(S)/udevadm.c \
 $(S)/udevadm-control.c \
 $(S)/udevadm-hwdb.c \
 $(S)/udevadm-info.c \
 $(S)/udevadm-monitor.c \
 $(S)/udevadm-settle.c \
 $(S)/udevadm-test.c \
 $(S)/udevadm-test-builtin.c \
 $(S)/udevadm-trigger.c \
 android/qsortr.c

LOCAL_C_INCLUDES += \
 $(LOCAL_PATH)/include \
 $(LOCAL_PATH)/android \
 $(LOCAL_PATH)/dist/src/shared \
 $(LOCAL_PATH)/dist/src/systemd \
 $(LOCAL_PATH)/dist/src/libudev \

LOCAL_CFLAGS += -Wno-missing-field-initializers
LOCAL_CFLAGS += -std=gnu99
LOCAL_CFLAGS += -include $(LOCAL_PATH)/android/udev.h
LOCAL_CFLAGS += -DVERSION=\"$(shell head -n 1 $(LOCAL_PATH)/VERSION)\"

LOCAL_STATIC_LIBRARIES := libudev libcutils liblog libc

LOCAL_MODULE := udevadm
LOCAL_MODULE_TAGS := optional

LOCAL_FORCE_STATIC_EXECUTABLE := true
LOCAL_MODULE_PATH := $(TARGET_ROOT_OUT)/sbin
LOCAL_UNSTRIPPED_PATH := $(TARGET_ROOT_OUT_UNSTRIPPED)/sbin

#include $(BUILD_EXECUTABLE)

### udevd

include $(CLEAR_VARS)

S:=dist/src/udev

LOCAL_C_INCLUDES += \
 $(LOCAL_PATH)/include \
 $(LOCAL_PATH)/android \
 $(LOCAL_PATH)/dist/src/shared \
 $(LOCAL_PATH)/dist/src/systemd \
 $(LOCAL_PATH)/dist/src/libudev \

LOCAL_SRC_FILES:= \
 $(S)/udevd.c \
 $(S)/udev-builtin.c \
 $(S)/udev-builtin-btrfs.c \
 $(S)/udev-builtin-firmware.c \
 $(S)/udev-builtin-hwdb.c \
 $(S)/udev-builtin-input_id.c \
 $(S)/udev-builtin-keyboard.c \
 $(S)/udev-builtin-net_id.c \
 $(S)/udev-builtin-path_id.c \
 $(S)/udev-builtin-usb_id.c \
 $(S)/udev-ctrl.c \
 $(S)/udev-event.c \
 $(S)/udev-node.c \
 $(S)/udev-rules.c \
 $(S)/udev-watch.c

LOCAL_CFLAGS += -Wno-missing-field-initializers
LOCAL_CFLAGS += -std=gnu99
LOCAL_CFLAGS += -include $(LOCAL_PATH)/android/udev.h
LOCAL_CFLAGS += -DVERSION=\"$(shell head -n 1 $(LOCAL_PATH)/VERSION)\"

LOCAL_STATIC_LIBRARIES := libudev libcutils liblog libc

LOCAL_MODULE := udevd
LOCAL_MODULE_TAGS := optional

LOCAL_FORCE_STATIC_EXECUTABLE := true
LOCAL_MODULE_PATH := $(TARGET_ROOT_OUT)/sbin
LOCAL_UNSTRIPPED_PATH := $(TARGET_ROOT_OUT_UNSTRIPPED)/sbin

#include $(BUILD_EXECUTABLE)


