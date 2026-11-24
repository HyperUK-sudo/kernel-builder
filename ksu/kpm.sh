#!/bin/bash
#
# SukiSU KPM

export maindir="$(pwd)"
export outside="${maindir}/.."
source "${outside}/$1env"

echo 'CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KPM=y' >> "${defconfig_file}"