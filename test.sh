#!/bin/bash
GITHUB_TOKEN="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"

# Test environment variables are set when release tag is not specified
SETUP_OUTPUTS=$(GITHUB_REPOSITORY="Concept-Art-House/action-use" ./setup.sh)
EXPECTED_SETUP_OUTPUTS=$'::set-output name=release-tag::\n::set-output name=github-owner::Concept-Art-House\n::set-output name=github-repo::action-use'

if [ "$SETUP_OUTPUTS" != "$EXPECTED_SETUP_OUTPUTS" ]; then
    echo "Expected \"$SETUP_OUTPUTS\" to equal \"$EXPECTED_SETUP_OUTPUTS\""
    exit 1
fi

# Test environment variables are set when release tag is specified
SETUP_OUTPUTS=$(GITHUB_REPOSITORY="Concept-Art-House/action-use@v0" ./setup.sh)
EXPECTED_SETUP_OUTPUTS=$'::set-output name=release-tag::v0\n::set-output name=github-owner::Concept-Art-House\n::set-output name=github-repo::action-use'

if [ "$SETUP_OUTPUTS" != "$EXPECTED_SETUP_OUTPUTS" ]; then
    echo "Expected \"$SETUP_OUTPUTS\" to equal \"$EXPECTED_SETUP_OUTPUTS\""
    exit 1
fi

# Test that the download directory is created
source functions.sh

FIXTURE_DIRECTORY="__fixtures__"
# Clean up any existing fixture directory from previous runs
rm -rf "$FIXTURE_DIRECTORY"

DOWNLOAD_DIRECTORY="$FIXTURE_DIRECTORY/Concept-Art-House/action-use"
setup_download_directory $DOWNLOAD_DIRECTORY

if [ ! -d "$DOWNLOAD_DIRECTORY" ]; then
    echo "Expected \"$DOWNLOAD_DIRECTORY\" to exist"
    exit 1
fi

download_action "https://api.github.com/repos/Concept-Art-House/action-use/tarball/v0" "$GITHUB_TOKEN" "$DOWNLOAD_DIRECTORY"