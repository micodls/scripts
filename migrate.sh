#!/usr/bin/env bash

for branch in `git branch -a | grep remotes | grep -v HEAD | grep -v master`; do
    IFS='/' read -r -a array <<< "$branch"
    nb="${array[2]}"
    git checkout -b $nb "origin/"$nb
done

# #!/usr/bin/env bash

# for directory in `find . -type d -maxdepth 1 -mindepth 1`; do
#     pushd $directory
#     # git remote rm origin
#     # git remote rename new-origin origin
#     # git checkout master
#     # git branch -u origin/master master
#     # git config --list
#     # git branch -a
#     popd
# done