#!/usr/bin/env bash

# for branch in `git branch -a | grep remotes | grep -v HEAD | grep -v master`; do
#     IFS='/' read -r -a array <<< "$branch"
#     nb="${array[2]}"
#     git checkout -b $nb "origin/"$nb
# done
echo '=============='
for directory in `find . -maxdepth 1 -mindepth 1 -type d`; do
    pushd $directory
    # IFS='/' read -r -a array <<< "$directory"
    # nb="${array[1]}"
    # git remote set-url origin git@git.corp.voyager.ph:smartservicerecode/$nb.git
    # git config --list
    # git remote rm origin
    # git remote rename new-origin origin
    # git checkout master
    # git branch -u origin/master master
    # git config --list
    git branch -a
    popd
done