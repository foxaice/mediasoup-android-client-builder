#!/bin/bash

export WEBRTC_VERSION_BRANCH_NAME="6099"

export MEDIASOUP_ANDROID_CLIENT_VERSION_NAME="3.4.1"

export ANDROID_NDK_VERSION="25.1.8937393"
export CMAKE_VERSION="3.22.1"
export ANDROID_SDK_BUILD_TOOLS_VERSION="30.0.2"
export ANDROID_SDK_PLATFORM_VERSION="android-30"

export SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

SUPPORTED_ARCHS=("x86_64" "armeabi-v7a" "arm64-v8a")

$SCRIPT_DIR/1_install_prebuild_dependencies.sh
source $SCRIPT_DIR/2_inject_prebuild_dependencies.sh
$SCRIPT_DIR/3_get_webrtc_android_sources.sh
$SCRIPT_DIR/4_checkout_webrtc_working_branch.sh
$SCRIPT_DIR/5_apply_patches.sh
$SCRIPT_DIR/6_build_webrtc.sh "${SUPPORTED_ARCHS[@]}"
$SCRIPT_DIR/7_get_actual_android_mediasoup_client_version.sh
$SCRIPT_DIR/8_inject_webrtc_dependencies_to_android_mediasoup_client.sh "${SUPPORTED_ARCHS[@]}"
$SCRIPT_DIR/9_get_android_sdk_dependecies.sh
$SCRIPT_DIR/10_build_android_mediasoup_client.sh
