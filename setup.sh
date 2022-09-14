#!/bin/bash

if [ -z "$GITHUB_REPOSITORY" ]; then
    echo "GITHUB_REPOSITORY is not set"
    exit 1
fi

if [[ "$GITHUB_REPOSITORY" == *"@"* ]]; then
    RELEASE_TAG="${GITHUB_REPOSITORY##*@}"
    echo "::set-output name=release-tag::$RELEASE_TAG"

    GITHUB_REPOSITORY="${GITHUB_REPOSITORY%@*}"
fi

GITHUB_OWNER="${GITHUB_REPOSITORY%%/*}"
GITHUB_REPO="${GITHUB_REPOSITORY#*/}"

echo "::set-output name=github-owner::$GITHUB_OWNER"
echo "::set-output name=github-repo::$GITHUB_REPO"
