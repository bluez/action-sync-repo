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

echo "##### Clone destination repo"
git clone https://x-access-token:$SECRET_TOKEN@github.com/$DEST_REPO.git $WORK_DIR
cd $WORK_DIR
git log -1

echo "##### Add remote repo"
git remote -v
git remote add upstream "$SRC_REPO"
git fetch upstream
git remote -v

echo "##### push for-upstream branch"
git push origin "refs/remotes/upstream/for-upstream:refs/heads/for-upstream" -f

echo "##### push master branch"
git push origin "refs/remotes/upstream/master:refs/heads/master" -f

echo "##### clean up"
git remote rm upstream
git remote -v
