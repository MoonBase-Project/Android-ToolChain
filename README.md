# Android-ToolChain

GCC Cross Compiler Toolchain

For Inline Kernel Build With Soong

First Add Support For NEW_GCC

https://github.com/MoonBase-Project/android_vendor_dot/commit/06e25005cd7fcec4b3c1449102d275a81a38eda1

Cherry-pick This ^ Commit On vendor/[ROM_NAME]/

Then Clone This Repo And Place

ARM64:
prebuilts/gcc/linux-x86/aarch64/aarch64-elf

ARM32:
prebuilts/gcc/linux-x86/aarch64/arm-eabi-

Set On Dt/BoardConfig.mk

KERNEL_TOOLCHAIN := $(PWD)/prebuilts/gcc/linux-x86/aarch64/aarch64-elf/bin
TARGET_KERNEL_CROSS_COMPILE_PREFIX := aarch64-elf-
TARGET_KERNEL_NEW_GCC_COMPILE := true

Build By JavaShin-X
