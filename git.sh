#!/bin/bash

read -p "Commit message: " commitMessage

if [[ -z "$commitMessage" ]]; then
  echo "Commit message cannot be empty"
  exit 1
fi

git add .
git commit -m "$commitMessage"

read -p "Push to remote? (y/n): " doYouWantToPush

if [[ "$doYouWantToPush" == "y" || "$doYouWantToPush" == "Y" ]]; then
  git push
fi
