#!/usr/bin/env bash

# cd root directory
# updates and cleans remote and local branches
echo '=============='
for directory in `find . -maxdepth 1 -mindepth 1 -type d`; do
    pushd $directory
    if [ -d .git ]; then
        git checkout master
        git pull --rebase
        git remote prune origin
        git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -D
    fi;
    popd
done
