#!/bin/bash

if [[ -d ./android-sdk/cmdline-tools/tools ]]
then
    echo "Android SDK Command-Line Tools exist"
else
    echo "Android SDK Command-Line Tools downloading"
    wget https://dl.google.com/android/repository/commandlinetools-linux-8092744_latest.zip
    unzip commandlinetools-linux-8092744_latest.zip
    rm commandlinetools-linux-8092744_latest.zip
    mkdir -p android-sdk/cmdline-tools
    mv ./cmdline-tools android-sdk/cmdline-tools/tools
fi

export ANDROID_HOME=$SCRIPT_DIR/android-sdk

sdkmanager --update
yes | sdkmanager --licenses
sdkmanager "ndk;$ANDROID_NDK_VERSION"
sdkmanager "ndk-bundle"
sdkmanager "cmake;$CMAKE_VERSION"
sdkmanager "emulator"
sdkmanager "platform-tools"
sdkmanager "build-tools;$ANDROID_SDK_BUILD_TOOLS_VERSION"
sdkmanager "platforms;$ANDROID_SDK_PLATFORM_VERSION"

