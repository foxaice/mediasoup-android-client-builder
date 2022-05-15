#!/bin/bash

cd ./webrtc_android/src

./build/install-build-deps.sh
./build/install-build-deps-android.sh
source build/android/envsetup.sh

echo "Gn gen for x64"
gn gen out/x86_64 --args='ffmpeg_branding="Chrome" rtc_use_h264=true is_clang=true is_component_build=false is_debug=false rtc_build_examples=false rtc_build_tools=false rtc_enable_protobuf=false rtc_include_tests=false use_custom_libcxx=false target_os="android" target_cpu="x64"'

echo "Gn gen for arm"
gn gen out/armeabi-v7a --args='ffmpeg_branding="Chrome" rtc_use_h264=true is_clang=true is_component_build=false is_debug=false rtc_build_examples=false rtc_build_tools=false rtc_enable_protobuf=false rtc_include_tests=false use_custom_libcxx=false target_os="android" target_cpu="arm"'

echo "Gn gen for arm64"
gn gen out/arm64-v8a --args='ffmpeg_branding="Chrome" rtc_use_h264=true is_clang=true is_component_build=false is_debug=false rtc_build_examples=false rtc_build_tools=false rtc_enable_protobuf=false rtc_include_tests=false use_custom_libcxx=false target_os="android" target_cpu="arm64"'

echo "Build x64"
ninja -C ./out/x86_64/

echo "Build arm86"
ninja -C ./out/armeabi-v7a/

echo "Build arm64"
ninja -C ./out/arm64-v8a/

echo "Build aar"
./tools_webrtc/android/build_aar.py --arch "x86_64 armeabi-v7a arm64-v8a" --extra-gn-args 'ffmpeg_branding="Chrome" rtc_use_h264=true is_clang=true is_component_build=false is_debug=false rtc_build_examples=false rtc_build_tools=false rtc_enable_protobuf=false rtc_include_tests=false use_custom_libcxx=false'

mkdir -p ../build_output
cd ../build_output
mkdir x86_64 arm64-v8a armeabi-v7a
cd ../src

cp -v ./libwebrtc.aar ../build_output/libwebrtc.aar
cp -v ./out/x86_64/obj/libwebrtc.a ../build_output/x86_64/libwebrtc.a 
cp -v ./out/arm64-v8a/obj/libwebrtc.a ../build_output/arm64-v8a/libwebrtc.a 
cp -v ./out/armeabi-v7a/obj/libwebrtc.a ../build_output/armeabi-v7a/libwebrtc.a
