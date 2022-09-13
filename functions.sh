#!/bin/bash

function setup_download_directory() {
    local dir=$1

    mkdir -p $dir
}

function download_action() {
    local url=$1
    local token=$2
    local dir=$3

    curl "$url" -sL --user "$token:x-oauth-basic" --output - | tar -xzf - -C $dir --strip-components=1 # Extract the archive to the actions directory
}