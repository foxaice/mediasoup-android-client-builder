#!/bin/bash

if [[ -d ./webrtc_android ]]
then
	echo "WebRTC Sources exist"
else
	echo "Creating WebRTC Directory"
	mkdir webrtc_android
	cd webrtc_android
	echo "Fetching WebRTC"
	fetch --nohooks webrtc_android
fi
