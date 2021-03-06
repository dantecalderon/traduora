#!/bin/bash
# usage: bin/release.sh 1.2.3

set -e

if [[ $1 == "" ]]; then
    echo "No release version set"
    exit 1
fi

RELEASE=$1

if ! [[ $RELEASE =~ ^([0-9.]+)$ ]]; then
    echo "Release tag does not match expected pattern: MAJOR.MINOR.PATCH"
    exit 1
fi

if ! [[ -z $(git status -s) ]]; then
    echo "You have uncommited or staged changes on git, please commit them or stash them"
    exit 1
fi

echo "Running checks"
bin/check.sh

echo "Tagging and pushing release to upstream"
git tag $RELEASE -m "Release $RELEASE, please check the changelog for more details"
git push origin master --follow-tags

echo "Successfully pushed release $RELEASE to upstream"