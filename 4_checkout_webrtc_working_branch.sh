#!/bin/bash

cd ./webrtc_android/src

WORKING_BRANCH="branch-heads/$WEBRTC_VERSION_BRANCH_NAME"
CURRENT_BRANCH="$(git name-rev --name-only HEAD)"
if [[ "$CURRENT_BRANCH" != "remotes/$WORKING_BRANCH" ]]
then
	git checkout $WORKING_BRANCH --force
	echo "Branch switched to $WORKING_BRANCH"

	echo "Syncing with GClient"
	gclient sync -D --force
	#todo to fix this line below
	#should run the same command again, because an error occurs after the first run
	gclient sync -D --force
else
	echo "Already at $WORKING_BRANCH Branch"

	echo "Syncing with GClient"
	gclient sync -D
fi
