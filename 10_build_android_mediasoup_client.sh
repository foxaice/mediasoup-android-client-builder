#!/bin/bash

cd mediasoup-client-android	
bash ./gradlew cleanBuildCache && ./gradlew clean
bash ./gradlew assemble

cd $SCRIPT_DIR
rm -rfv ./output
cp -rv ./mediasoup-client-android/mediasoup-client/build/outputs/aar ./output
cp -v ./mediasoup-client-android/mediasoup-client/deps/webrtc/lib/libwebrtc.aar ./output/

printf "\n\n\n\n"
echo "                           *                           "
echo "                          ***                          "
echo "                          ***                          "
echo "                          ***                          "
echo "                          ***                          "
echo "             *            ***            *             "
echo "             **           ***           **             "
echo "             ***          ***          ***             "
echo "              ***         ***         ***              "
echo "               ****       ***       ****               "
echo "                ****      ***      ****                "
echo "                  ****    ***    ****                  "
echo "                   *****  ***  *****                   "
echo "                     *************                     "
echo "                      ***********                      "
echo "                        *******                        "
echo "                          ***                          "
echo "                           *                           "
echo "the final build output is here ---> $SCRIPT_DIR/output"
