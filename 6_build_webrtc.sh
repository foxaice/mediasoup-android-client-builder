#!/bin/bash

COMMON_ARGS='ffmpeg_branding="Chrome" rtc_use_h264=true is_clang=true is_component_build=false is_debug=false rtc_build_examples=false rtc_build_tools=false rtc_enable_protobuf=false rtc_include_tests=false use_custom_libcxx=false target_os="android"'

cd $SCRIPT_DIR/webrtc_android/src

./build/install-build-deps.sh
./build/install-build-deps-android.sh
source build/android/envsetup.sh


for arch_type in $ARCH_TYPES
do
 target_cpu=${SUPPORTED_ARCHS[$arch_type]}
 echo "Gn gen for $target_cpu"
 gn gen out/$arch_type --args="$COMMON_ARGS target_cpu=\"$target_cpu\""
done

for arch_type in $ARCH_TYPES
do
 target_cpu=${SUPPORTED_ARCHS[$arch_type]}
 echo "Build $target_cpu"
 ninja -C ./out/$arch_type/
done

echo "Build aar"
./tools_webrtc/android/build_aar.py --arch $ARCH_TYPES --extra-gn-args "$COMMON_ARGS"


mkdir -p ../build_output
cd ../build_output
rm -rf *

cp -v ../src/libwebrtc.aar ./libwebrtc.aar

for arch_type in $ARCH_TYPES
do
 mkdir $arch_type
 cp -v ../src/out/$arch_type/obj/libwebrtc.a ./$arch_type/libwebrtc.a
done
