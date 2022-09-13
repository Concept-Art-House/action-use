#!/bin/bash
source functions.sh

join_paths() {
    (IFS=/; echo "$*" | tr -s /)
}

DIRECTORY_PATH=$(join_paths $ACTIONS_DIRECTORY $GITHUB_OWNER $GITHUB_REPO $RELEASE_TAG)

setup_download_directory $DIRECTORY_PATH
download_action "https://api.github.com/repos/$GITHUB_OWNER/$GITHUB_REPO/tarball/$RELEASE_TAG" "$GITHUB_TOKEN" "$DIRECTORY_PATH"
