LOCAL_PATH:= $(call my-dir)

# We need to build this for both the device (as a static library)
# and the host (as a static library for tools to use).

common_SRC_FILES := \
	png.c \
	pngerror.c \
	pngget.c \
	pngmem.c \
	pngpread.c \
	pngread.c \
	pngrio.c \
	pngrtran.c \
	pngrutil.c \
	pngset.c \
	pngtrans.c \
	pngwio.c \
	pngwrite.c \
	pngwtran.c \
	pngwutil.c

common_CFLAGS := -DPNG_USER_CONFIG

common_C_INCLUDES += \

common_COPY_HEADERS_TO := libpng
common_COPY_HEADERS := png.h pngconf.h pngusr.h

# For the host
# =====================================================

include $(CLEAR_VARS)

LOCAL_SRC_FILES := $(common_SRC_FILES)
LOCAL_CFLAGS += $(common_CFLAGS)
LOCAL_C_INCLUDES += $(common_C_INCLUDES) external/zlib

LOCAL_MODULE:= libpng

LOCAL_COPY_HEADERS_TO := $(common_COPY_HEADERS_TO)
LOCAL_COPY_HEADERS := $(common_COPY_HEADERS)

include $(BUILD_HOST_STATIC_LIBRARY)


# For the device
# =====================================================

include $(CLEAR_VARS)

LOCAL_SRC_FILES := $(common_SRC_FILES) \
                   arm/filter_neon.S
LOCAL_CFLAGS += $(common_CFLAGS) \
                 -DPNG_ARM_NEON -DPNG_ALIGNED_MEMORY_SUPPORTED
LOCAL_C_INCLUDES += $(common_C_INCLUDES) \
	external/zlib
LOCAL_SHARED_LIBRARIES := \
	libz libm

LOCAL_MODULE:= libpng

LOCAL_COPY_HEADERS_TO := $(common_COPY_HEADERS_TO)
LOCAL_COPY_HEADERS := $(common_COPY_HEADERS)

include $(BUILD_STATIC_LIBRARY)


# Test Program pngvalid
# =====================================================

include $(CLEAR_VARS)

LOCAL_SRC_FILES:= pngvalid.c

LOCAL_STATIC_LIBRARIES := libpng libz

LOCAL_C_INCLUDES := $(LOCAL_PATH) \
	external/zlib

LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLE)

LOCAL_MODULE_TAGS := debug

LOCAL_MODULE := pngvalid

include $(BUILD_EXECUTABLE)

# Test Program pngtest
# =====================================================

include $(CLEAR_VARS)

LOCAL_SRC_FILES:= pngtest.c

LOCAL_STATIC_LIBRARIES := libpng libz

LOCAL_C_INCLUDES := $(LOCAL_PATH) \
	external/zlib

LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLE)

LOCAL_MODULE_TAGS := debug

LOCAL_MODULE := pngtest

include $(BUILD_EXECUTABLE)

# Test Program pngtest for the host
# =====================================================

include $(CLEAR_VARS)

LOCAL_SRC_FILES:= pngtest.c

LOCAL_STATIC_LIBRARIES := libpng libz

LOCAL_C_INCLUDES := $(LOCAL_PATH) \
	external/zlib

LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLE)

LOCAL_MODULE_TAGS := debug

LOCAL_MODULE := pngtest

include $(BUILD_HOST_EXECUTABLE)
