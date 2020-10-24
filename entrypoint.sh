#!/bin/bash

set -e

if [ -z "$SECRET_TOKEN" ]; then
    echo "Set SECRET_TOKEN environment variable"
    exit 1
fi

if [ "$FOR_UPSTREAM_BRANCH" = 'none' ]; then
    /sync_repo.sh "$@"
else
    /sync_repo_for_upstream.sh "$@"
fi
