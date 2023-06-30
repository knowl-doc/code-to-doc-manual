#!/bin/bash

repo=$GITHUB_REPOSITORY
IFS="/" read -ra components <<< "$repo"
owner=${components[0]}
repository=${components[1]}

export COMMIT_SHA="$GITHUB_SHA"
export REPO_NAME="$repository"
export OWNER_NAME="$owner"
export KNOWL_BACKEND_HTTP="https://api.knowl.io/"
export BRANCH_NAME="$GITHUB_REF_NAME"
export GIT_PLATFORM="github"
export PROJECT_NAME="$repository"

git config --global --add safe.directory $GITHUB_WORKSPACE
cd /usr/app
./start_doc_gen.sh $GITHUB_WORKSPACE
