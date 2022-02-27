#!/bin/bash

if [[ -d ./mediasoup-client-android ]]
then
    echo "Mediasoup-client-android exists"
else
    echo "Mediasoup-client-android downloading"
    git clone https://github.com/foxaice/mediasoup-client-android.git
fi

cd $SCRIPT_DIR/mediasoup-client-android

echo "Checkout $VERSION_BRANCH in Mediasoup-client-android"

VERSION_BRANCH="version/$MEDIASOUP_ANDROID_CLIENT_VERSION_NAME"
CURRENT_BRANCH="$(git rev-parse --abbrev-ref HEAD)"

if [[ "$CURRENT_BRANCH" == "$VERSION_BRANCH" ]]
then
    echo "$VERSION_BRANCH Branch already exists"
else
    git checkout -B version/$MEDIASOUP_ANDROID_CLIENT_VERSION_NAME -f $MEDIASOUP_ANDROID_CLIENT_VERSION_NAME
fi

