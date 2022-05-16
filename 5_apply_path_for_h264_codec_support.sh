#!/bin/bash

function get_alter_arch_name() {
 local arch_type="$1"
 if [[ $arch_type == "x86_64" ]]
 then
  alter_arch_name="x64"
 elif [[ $arch_type == "armeabi-v7a" ]]
 then
  alter_arch_name="arm-neon"
 elif [[ $arch_type == "arm64-v8a" ]]
 then
  alter_arch_name="arm64"
 fi
 echo "$alter_arch_name"
}

ARCH_TYPES=("$@")

cd $SCRIPT_DIR
tar -xvf webrtc_h264_support.patch

cp h264_webrtc_patch/ffmpeg_generated.gni webrtc_android/src/third_party/ffmpeg/ffmpeg_generated.gni

CHROME_FFMPEG_BRANDING_DIR=$SCRIPT_DIR/webrtc_android/src/third_party/ffmpeg/chromium/config/Chrome/android

for arch in "${ARCH_TYPES[@]}"
do
 arch="$(get_alter_arch_name $arch)"
 cp -v h264_webrtc_patch/$arch/config.h $CHROME_FFMPEG_BRANDING_DIR/$arch/config.h
 cp -v h264_webrtc_patch/$arch/libavcodec/codec_list.c $CHROME_FFMPEG_BRANDING_DIR/$arch/libavcodec/codec_list.c
 cp -v h264_webrtc_patch/$arch/libavcodec/parser_list.c $CHROME_FFMPEG_BRANDING_DIR/$arch/libavcodec/parser_list.c
done

rm -rf h264_webrtc_patch/
