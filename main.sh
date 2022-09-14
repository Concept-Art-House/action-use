#!/bin/bash
source functions.sh

DIRECTORY_PATH=$(join_paths $ACTIONS_DIRECTORY_PATH $GH_OWNER $GH_REPO@$RELEASE_TAG)

setup_download_directory $DIRECTORY_PATH
download_action "https://api.github.com/repos/$GH_OWNER/$GH_REPO/tarball/$RELEASE_TAG" "$GH_ACCESS_TOKEN" "$DIRECTORY_PATH"
