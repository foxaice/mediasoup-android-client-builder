#!/bin/bash

cd $SCRIPT_DIR
tar -xvf webrtc_h264_support.patch

cp h264_webrtc_patch/ffmpeg_generated.gni webrtc_android/src/third_party/ffmpeg/ffmpeg_generated.gni

CHROME_FFMPEG_BRANDING_DIR=$SCRIPT_DIR/webrtc_android/src/third_party/ffmpeg/chromium/config/Chrome/android
SUPPORT_ARCH_ARRAY=('arm64' 'arm-neon' 'x64')

for arch in "${SUPPORT_ARCH_ARRAY[@]}"
do
 cp -v h264_webrtc_patch/$arch/config.h $CHROME_FFMPEG_BRANDING_DIR/$arch/config.h
 cp -v h264_webrtc_patch/$arch/libavcodec/codec_list.c $CHROME_FFMPEG_BRANDING_DIR/$arch/libavcodec/codec_list.c
 cp -v h264_webrtc_patch/$arch/libavcodec/parser_list.c $CHROME_FFMPEG_BRANDING_DIR/$arch/libavcodec/parser_list.c
done

rm -rf h264_webrtc_patch/
