# Android-ToolChain

GCC Cross Compiler Toolchain

For Inline Kernel Build With Soong

1. Clone This Repo :

gti clone --depth=1 https://github.com/MoonBase-Project/Android-ToolChain.git -b main

2. Add Support For NEW_GCC :

Cherry-pick This Commit On vendor/[ROM_NAME]/ 

git fetch https://github.com/MoonBase-Project/android_vendor_dot 06e25005cd7fcec4b3c1449102d275a81a38eda1
git cherry-pick FETCH_HEAD

Or Use "patch -p1 -i gnu_gcc_new.patch in vendor/[ROM_NAME]/"

3. Then Place Folders :

ARM64 :
prebuilts/gcc/linux-x86/aarch64/aarch64-elf

ARM32 :
prebuilts/gcc/linux-x86/arm/arm-eabi

4. Set On Dt/BoardConfig.mk :

KERNEL_TOOLCHAIN := $(PWD)/prebuilts/gcc/linux-x86/aarch64/aarch64-elf/bin
TARGET_KERNEL_CROSS_COMPILE_PREFIX := aarch64-elf-
TARGET_KERNEL_NEW_GCC_COMPILE := true

[-] NOTES :

* Only "C" Programming Language Is Supported By This ToolChain

* Gnu/Gcc AMD64 Is Optional And Can Be Used To Build
  Pc/Laptop X86_64 Linux Kernels Or Any "C" SourceCode

* Everything Here Requires : 
  Gnu/GlibC 2.34 And Up+ No Backwards Compatibility

* MAKE folder contains simple scripts used to build the binaries in this repository

Compiled By :

JavaShin-X
Android OS & Custom Kernel Modder
Saturday, January 01 2022
