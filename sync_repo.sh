#!/bin/sh -l

set -e

SRC_REPO=$1
SRC_BRANCH=$2
DEST_REPO=$3
DEST_BRANCH=$4
BASEDIR=$(pwd)

echo "SRC_REPO=$SRC_REPO"
echo "SRC_BRANCH=$SRC_BRANCH"
echo "DEST_REPO=$DEST_REPO"
echo "DEST_BRANCH=$DEST_BRANCH"
echo "GITHUB_ACTOR=$GITHUB_ACTOR"
echo "BASEDIR=$BASEDIR"

git config user.name "$GITHUB_ACTOR"
git config user.email "$GITHUB_ACTOR@users.noreply.github.com"

WORK_DIR=$(pwd)/workdir

# Clone destination repo first
git clone --depth 1 https://x-access-token:$SECRET_TOKEN@github.com/$DEST_REPO.git $WORK_DIR
cd $WORK_DIR

git remote -v
git checkout $DEST_BRANCH
git remote add upstream "$SRC_REPO"
git fetch upstream
git remote -v

git push origin "refs/remotes/upstream/$SRC_BRANCH:refs/heads/$DEST_BRANCH" -f
git remote rm upstream
git remote -v
