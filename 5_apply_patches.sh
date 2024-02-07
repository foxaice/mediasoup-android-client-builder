#!/bin/bash

#"git apply some.patch" causes errors when reapplying a patch.
# It may be fixed by:
# "git apply abc.patch || git apply abc.patch -R --check && echo already applied"
# But this behavior allows you to see real errors during the first patch.


cd $SCRIPT_DIR/webrtc_android/src/third_party/ffmpeg
git apply $SCRIPT_DIR/webrtc_h264_support.patch


# Who use "use_custom_libcxx=false" argument build for android
# got "undefined symbol: _Unwind_Backtrace" mistake should do like this:
# https://bugs.chromium.org/p/webrtc/issues/detail?id=13535
cd $SCRIPT_DIR/webrtc_android/src/buildtools
git apply $SCRIPT_DIR/use_custom_libcxx_argument_buildtools_support.patch

cd $SCRIPT_DIR/webrtc_android/src/build
git apply $SCRIPT_DIR/use_custom_libcxx_argument_build_support.patch


#webrtc_voice_engine.cc create a default AudioDeviceModule if no supplied.
#    adm_ = webrtc::AudioDeviceModule::Create(
#       webrtc::AudioDeviceModule::kPlatformDefaultAudio, task_queue_factory_)
cd $SCRIPT_DIR/webrtc_android/src/media/engine
git apply $SCRIPT_DIR/support_default_audio_device_module_for_webrtc_voice_engine.patch

