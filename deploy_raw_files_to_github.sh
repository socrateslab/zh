#!/bin/bash

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

# git pull first
git pull origin master

# Add changes to git.
git add -A

# Commit changes.
msg="rebuilding site"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

# Push source and build repos.
git push origin master
