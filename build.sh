#########################################################################
# File Name: build.sh
# Author: Sues
# mail: sumory.kaka@foxmail.com
# Created Time: Thu 03 Sep 2020 03:30:14 PM CST
# Version : 1.0
#########################################################################
#!/bin/bash
CPU_NM=`cat /proc/cpuinfo  |grep processor | wc -l`
let cpu_power=${CPU_NM}*5/5
[ ${cpu_power} -lt 1 ] && let cpu_power=1
make -j20 O=OUT


if [ -e OUT/images/rootfs.yaffs2 ];then
    rm OUT/images/rootfs.yaffs2
fi

if [ -e OUT/images/rootfs.tar.gz ];then
    rm OUT/images/rootfs_to_gen_yaffs2 -rf
    mkdir OUT/images/rootfs_to_gen_yaffs2
    tar xf OUT/images/rootfs.tar.gz -C OUT/images/rootfs_to_gen_yaffs2

    ./mkyaffs2image-nand2g OUT/images/rootfs_to_gen_yaffs2 OUT/images/rootfs.yaffs2
fi
