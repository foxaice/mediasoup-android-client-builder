#!/bin/bash

cd ./webrtc_android/src

WORKING_BRANCH="branch-heads/$WEBRTC_VERSION_BRANCH_NAME"
CURRENT_BRANCH="$(git name-rev --name-only HEAD)"
if [[ "$CURRENT_BRANCH" != "remotes/$WORKING_BRANCH" ]]
then
	git checkout $WORKING_BRANCH
	echo "Branch switched to $WORKING_BRANCH"
else
	echo "Already at $WORKING_BRANCH Branch"
fi

echo "Syncing with GClient"
gclient sync -D
