#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

#
# All components inherited here go to system image
#
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_system.mk)

# Enable mainline checking
PRODUCT_ENFORCE_ARTIFACT_PATH_REQUIREMENTS := relaxed

#
# All components inherited here go to system_ext image
#
$(call inherit-product, $(SRC_TARGET_DIR)/product/handheld_system_ext.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/telephony_system_ext.mk)

#
# All components inherited here go to product image
#
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_product.mk)

#
# All components inherited here go to vendor image
#
# TODO(b/136525499): move *_vendor.mk into the vendor makefile later
TARGET_SUPPORTS_OMX_SERVICE := false
$(call inherit-product, $(SRC_TARGET_DIR)/product/handheld_vendor.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/telephony_vendor.mk)

include device/google/coral/flame/device.mk

# Device identifier. This must come after all inclusions
PRODUCT_BRAND := google
PRODUCT_DEVICE := flame
PRODUCT_MANUFACTURER := Google
PRODUCT_MODEL := Pixel 4
PRODUCT_NAME := lineage_flame

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="flame-user 13 TP1A.221005.002.B2 9382335 release-keys" \
    BuildFingerprint=google/flame/flame:13/TP1A.221005.002.B2/9382335:user/release-keys \
    DeviceProduct=flame

$(call inherit-product, vendor/google/flame/flame-vendor.mk)

# Avium UI Specific Configs
AVIUM_VERSION_APPEND_TIME_OF_DAY := true
AVIUM_MAINTAINER := DonnerTech
AVIUM_SETTINGS_SOC_MODEL_NAME := Snapdragon 855
AVIUM_SETTINGS_DEVICE_CODENAME := flame

# Включить Google сервисы
WITH_GMS := true

# Спуфинг для обхода блокировок (Play Integrity)
AVIUM_FORCE_SET_FAKE_PROP := true

# Блюр в системе (у Pixel 4 хватает мощности)
TARGET_FORCE_ENABLE_BLUR := true

# Отключаем проверку путей для GMS
PRODUCT_ENFORCE_ARTIFACT_PATH_REQUIREMENTS := false
