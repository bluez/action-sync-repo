#!/bin/bash

set -e

if [ -z "$SECRET_TOKEN" ]; then
    echo "Set SECRET_TOKEN environment variable"
    exit 1
fi

echo "Add the workspace dir to GIT safe directory"
git config --global --add safe.directory $GITHUB_WORKSPACE

echo "Add user name and email to global config"
git config --global user.name "$GITHUB_ACTOR"
git config --global user.email "$GITHUB_ACTOR@users.noreply.github.com"

if [ "$FOR_UPSTREAM_BRANCH" = 'none' ]; then
    /sync_repo.sh "$@"
else
    /sync_repo_for_upstream.sh "$@"
fi
