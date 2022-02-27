#!/bin/bash

export ANDROID_HOME=$SCRIPT_DIR/android-sdk
export PATH=$ANDROID_HOME/cmdline-tools/tools/bin:$PATH
export PATH=$ANDROID_HOME/platform-tools:$PATH
export PATH=~+/symlinks:$PATH
export PATH=~+/depot_tools:$PATH

rm -rf symlinks
mkdir symlinks
ln -s /usr/bin/python2.7 ./symlinks/python
