#!/bin/bash

export WEBRTC_VERSION_BRANCH_NAME="4606"

export MEDIASOUP_ANDROID_CLIENT_VERSION_NAME="3.3.0"

export ANDROID_NDK_VERSION="20.0.5594570"
export CMAKE_VERSION="3.10.2.4988404"
export ANDROID_SDK_BUILD_TOOLS_VERSION="30.0.2"
export ANDROID_SDK_PLATFORM_VERSION="android-30"

export SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

$SCRIPT_DIR/1_install_prebuild_dependencies.sh
source $SCRIPT_DIR/2_inject_prebuild_dependencies.sh
$SCRIPT_DIR/3_get_webrtc_android_sources.sh
$SCRIPT_DIR/4_checkout_webrtc_working_branch.sh
#$SCRIPT_DIR/5_apply_path_for_h264_codec_support.sh
$SCRIPT_DIR/5_build_webrtc.sh
$SCRIPT_DIR/6_get_actual_android_mediasoup_client_version.sh
$SCRIPT_DIR/7_inject_webrtc_dependencies_to_android_mediasoup_client.sh
$SCRIPT_DIR/8_get_android_sdk_dependecies.sh
$SCRIPT_DIR/9_build_android_mediasoup_client.sh
