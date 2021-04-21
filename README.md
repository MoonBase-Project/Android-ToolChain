# Android-ToolChain
GCC Cross Compiler Toolchain

For Inline Kernel Build With Soong.

Clone This Repo And Place On 
prebuilts/gcc/linux-x86/aarch64/aarch64-elf

Set On Dt/BoardConfig.mk

KERNEL_TOOLCHAIN := $(PWD)/prebuilts/gcc/linux-x86/aarch64/aarch64-elf/bin
TARGET_KERNEL_CROSS_COMPILE_PREFIX := aarch64-elf-

Build By JavaShin-X
