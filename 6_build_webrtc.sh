#!/bin/bash

function get_target_cpu() {
 local arch_type="$1"
 if [[ $arch_type == "x86" ]]
 then
  target_cpu="x86"
 elif [[ $arch_type == "x86_64" ]]
 then
  target_cpu="x64"
 elif [[ $arch_type == "armeabi-v7a" ]]
 then
  target_cpu="arm"
 elif [[ $arch_type == "arm64-v8a" ]]
 then
  target_cpu="arm64"
 fi
 echo "$target_cpu"
}

# When building webrtc 6099 with is_debug=true, there was an error when turning off the camera:
# "mediasoup-android-client-builder/webrtc_android/src/pc/rtp_sender.cc", 799, "(signaling_thread_)->IsCurrent()" was observed.
# Printing out the thread name, it matched signaling_thread_, error is in the RTC_DCHECK_RUN_ON check itself.
# See related issue: https://groups.google.com/g/discuss-webrtc/c/pm56BSiAa-E
COMMON_ARGS='ffmpeg_branding="Chrome" rtc_use_h264=true is_clang=true is_component_build=false is_debug=false rtc_build_examples=false rtc_build_tools=false rtc_enable_protobuf=false rtc_include_tests=false use_custom_libcxx=false target_os="android"'

ARCH_TYPES=("$@")

cd $SCRIPT_DIR/webrtc_android/src

./build/install-build-deps.sh --android
source build/android/envsetup.sh


for arch_type in "${ARCH_TYPES[@]}"
do
 target_cpu="$(get_target_cpu $arch_type)"
 echo "Gn gen for $target_cpu"
 gn gen out/$arch_type --args="$COMMON_ARGS target_cpu=\"$target_cpu\""
done

for arch_type in "${ARCH_TYPES[@]}"
do
 target_cpu="$(get_target_cpu $arch_type)"
 echo "Build $target_cpu"
 ninja -C ./out/$arch_type/
done

echo "Build aar"
./tools_webrtc/android/build_aar.py --arch ${ARCH_TYPES[@]} --extra-gn-args "$COMMON_ARGS"


mkdir -p ../build_output
cd ../build_output
rm -rf *

cp -v ../src/libwebrtc.aar ./libwebrtc.aar

for arch_type in "${ARCH_TYPES[@]}"
do
 mkdir $arch_type
 cp -v ../src/out/$arch_type/obj/libwebrtc.a ./$arch_type/libwebrtc.a
done
