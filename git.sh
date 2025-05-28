#!/bin/bash

if [ -z "$1" ]; then
  read -r -p "Commit message: " commitMessage
else
  commitMessage=$1
  shift
fi

if [[ -z "$commitMessage" ]]; then
  echo "Commit message cannot be empty"
  exit 1
fi

if [ $# -eq 0 ]; then
  echo "Adding all changes..."
  git add .
else
  echo "Adding specified files..."
  for file in "$@"; do
    git add -- "$file"
  done
fi

echo "Committing..."
if ! git commit -m "$commitMessage"; then
  echo "Commit failed"
  exit 1
fi

read -r -p "Push to remote? (y/N): " doYouWantToPush
if [[ "$doYouWantToPush" =~ ^[Yy]$ ]]; then
  currentBranch=$(git rev-parse --abbrev-ref HEAD)

  upstream=$(git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null)

  if [[ -z "$upstream" ]]; then
    echo "No upstream configured for branch '$currentBranch'. Setting upstream and pushing..."
    git push --set-upstream origin "$currentBranch" || { echo "Push failed"; exit 1; }
  else
    echo "Pushing to remote..."
    git push || { echo "Push failed"; exit 1; }
  fi
fi
