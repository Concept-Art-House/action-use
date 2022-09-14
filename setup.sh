if [ -z "$GH_REPOSITORY" ]; then
    echo "GH_REPOSITORY is not set"
    exit 1
fi

if [[ "$GH_REPOSITORY" =~ "@" ]]; then
    RELEASE_TAG="${GH_REPOSITORY##*@}"
    GH_REPOSITORY="${GH_REPOSITORY%@*}"
fi

GH_OWNER="${GH_REPOSITORY%%/*}"
GH_REPO="${GH_REPOSITORY#*/}"

echo "::set-output name=release-tag::$RELEASE_TAG"
echo "::set-output name=github-owner::$GH_OWNER"
echo "::set-output name=github-repo::$GH_REPO"