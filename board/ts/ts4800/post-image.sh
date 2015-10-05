#!/bin/bash
#
# Copyright (C) 2015 Savoir-Faire Linux
# Post image generation script.

IDIR="$1"

BOARD_DIR="board/ts/ts4800"
GENIMAGE_CFG="${BOARD_DIR}/genimage.cfg"
GENIMAGE_TMP=${BUILD_DIR}/.genimage_tmp

cp -f ${BOARD_DIR}/mbrboot.bin ${IDIR}/

${HOST_DIR}/usr/bin/genimage \
        --config ${GENIMAGE_CFG} \
        --rootpath ${TARGET_DIR} \
        --tmppath ${GENIMAGE_TMP} \
        --inputpath $IDIR \
        --outputpath $IDIR

ret=${?}
rm -rf ${GENIMAGE_TMP}
exit ${ret}

