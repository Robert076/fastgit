#!/bin/bash

read -p "Commit message: " commitMessage

if [[ -z "$commitMessage" ]]; then
  echo "Commit message cannot be empty"
  exit 1
fi

if [ $# -eq 0 ]; then

  git add .

else

  for file in "$@"
  do
    git add $file
  done
  
fi

git commit -m "$commitMessage"

read -p "Push to remote? (y/n): " doYouWantToPush 

if [[ "$doYouWantToPush" == "y" || "$doYouWantToPush" == "Y" ]]; then
  git push
fi
