#!/usr/bin/env bash
old_repo_url=$1
new_repo_url=$2
repo=$(basename $old_repo_url)

# Usage: ./migrate_repo.sh <old url> <new url>
# Example: ./migrate_repo.sh git@git.corp.voyager.ph:vcm/core-rework.git git@git.corp.voyager.ph:pmdelossantos/core-rework.git

echo "Migrating: $old_repo_url to $new_repo_url"

git clone --mirror $old_repo_url
pushd $PWD
pushd $repo
git remote set-url origin $new_repo_url # repo must already exist
git push --mirror origin
popd
rm -rf $repo
popd
