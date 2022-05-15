#!/bin/bash

cd $SCRIPT_DIR

cp -v webrtc_android/build_output/libwebrtc.aar mediasoup-client-android/mediasoup-client/deps/webrtc/lib

cp -rTv webrtc_android/build_output/arm64-v8a/ mediasoup-client-android/mediasoup-client/deps/webrtc/lib/arm64-v8a

cp -rTv webrtc_android/build_output/armeabi-v7a/ mediasoup-client-android/mediasoup-client/deps/webrtc/lib/armeabi-v7a

cp -rTv webrtc_android/build_output/x86_64/ mediasoup-client-android/mediasoup-client/deps/webrtc/lib/x86_64

echo "removing old WebRTC sources"
rm -rf mediasoup-client-android/mediasoup-client/deps/webrtc/src

echo "injecting new WebRTC sources"
ln -s $SCRIPT_DIR/webrtc_android/src/ mediasoup-client-android/mediasoup-client/deps/webrtc/src
