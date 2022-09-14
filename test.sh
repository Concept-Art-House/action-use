#!/bin/bash
source functions.sh

# Test that paths can be constructed correctly
TEST_PATH=$(join_paths user repo@tag)
EXPECTED_TEST_PATH="user/repo@tag"
if [ "$TEST_PATH" != "$EXPECTED_TEST_PATH" ]; then
    echo "Expected \"$EXPECTED_TEST_PATH\" to equal \"$TEST_PATH\""
    exit 1
fi

# Test environment variables are set when release tag is not specified
SETUP_OUTPUTS=$(GH_REPOSITORY="Concept-Art-House/action-use" ./setup.sh)
EXPECTED_SETUP_OUTPUTS=$'::set-output name=release-tag::\n::set-output name=github-owner::Concept-Art-House\n::set-output name=github-repo::action-use'

if [ "$SETUP_OUTPUTS" != "$EXPECTED_SETUP_OUTPUTS" ]; then
    echo "Expected \"$SETUP_OUTPUTS\" to equal \"$EXPECTED_SETUP_OUTPUTS\""
    exit 1
fi

# Test environment variables are set when release tag is specified
SETUP_OUTPUTS=$(GH_REPOSITORY="Concept-Art-House/action-use@v0" ./setup.sh)
EXPECTED_SETUP_OUTPUTS=$'::set-output name=release-tag::v0\n::set-output name=github-owner::Concept-Art-House\n::set-output name=github-repo::action-use'

if [ "$SETUP_OUTPUTS" != "$EXPECTED_SETUP_OUTPUTS" ]; then
    echo "Expected \"$SETUP_OUTPUTS\" to equal \"$EXPECTED_SETUP_OUTPUTS\""
    exit 1
fi

# Test that the download directory is created
source functions.sh

FIXTURE_DIRECTORY_PATH="__fixtures__"
# Clean up any existing fixture directory from previous runs
rm -rf "$FIXTURE_DIRECTORY_PATH"

DOWNLOAD_DIRECTORY_PATH="$FIXTURE_DIRECTORY_PATH/Concept-Art-House/action-use"
setup_download_directory $DOWNLOAD_DIRECTORY_PATH

if [ ! -d "$DOWNLOAD_DIRECTORY_PATH" ]; then
    echo "Expected \"$DOWNLOAD_DIRECTORY_PATH\" to exist"
    exit 1
fi

download_action "https://api.github.com/repos/Concept-Art-House/action-use/tarball" "$GITHUB_TOKEN" "$DOWNLOAD_DIRECTORY_PATH"