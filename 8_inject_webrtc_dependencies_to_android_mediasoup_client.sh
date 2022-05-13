#!/bin/bash

WEBRTC_OUTPUT_DIR=$SCRIPT_DIR/webrtc_android/build_output
WEBRTC_DEPS_DIR=$SCRIPT_DIR/mediasoup-client-android/mediasoup-client/deps/webrtc


cd $SCRIPT_DIR

cp -v $WEBRTC_OUTPUT_DIR/libwebrtc.aar $WEBRTC_DEPS_DIR/lib

for arch_type in $ARCH_TYPES
do
 cp -rTv $WEBRTC_OUTPUT_DIR/$arch_type/ $WEBRTC_DEPS_DIR/lib/$arch_type
done

echo "removing old WebRTC sources"
rm -rf $WEBRTC_DEPS_DIR/src

echo "injecting new WebRTC sources"
ln -s $SCRIPT_DIR/webrtc_android/src/ $WEBRTC_DEPS_DIR/src
