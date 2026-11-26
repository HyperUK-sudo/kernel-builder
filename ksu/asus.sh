#!/bin/bash
#
# SukiSU + SuSFS

export maindir="$(pwd)"
export outside="${maindir}/.."
source "${outside}/$1env"

curl -LSs "https://git.zako.shirkneko.top:20004/shirkneko/SukiSU/raw/branch/main/kernel/setup.sh" | bash -s builtin-new
git add . && git commit -am "drivers: KernelSU"
KSU_git_ver=$(cd KernelSU && git rev-list --count HEAD)
KSU_ver=$(($KSU_git_ver + 30000))

echo 'CONFIG_KSU_SUSFS=y
CONFIG_KSU_SUSFS_INLINE_HOOK=y
CONFIG_KSU_SUSFS_SUS_MOUNT=y
CONFIG_KSU_SUSFS_SUS_PATH=y
CONFIG_KSU_SUSFS_SUS_KSTAT=y
CONFIG_KSU_SUSFS_SPOOF_UNAME=y
CONFIG_KSU_SUSFS_ENABLE_LOG=y
CONFIG_KSU_SUSFS_HIDE_KSU_SUSFS_SYMBOLS=y
CONFIG_KSU_SUSFS_SPOOF_CMDLINE_OR_BOOTCONFIG=y
CONFIG_KSU_SUSFS_OPEN_REDIRECT=y
CONFIG_KSU_SUSFS_SUS_MAP=y' >> "${defconfig_file}"

sed -i "s/\(CONFIG_LOCALVERSION=\)\(.*\)/\1\"-${kernel_name}-ks${KSU_ver}sus\"/" "${defconfig_file}"

echo "$(grep 'CONFIG_LOCALVERSION=' ${defconfig_file})"

echo -e " \nincludes SukiSU, ver ${KSU_ver}" >> banner_append
echo -e " \nincludes SuSFS v2.4.0" >> banner_append

