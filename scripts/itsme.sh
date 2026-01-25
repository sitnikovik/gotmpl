#!/usr/bin/env sh

# Script to replace placeholders in specified files with provided GitHub nickname and repository name.
# Usage: ./itsme.sh <github_nickname> <github_repo_name>

GITHUB_NICKNAME=$1
GITHUB_REPO=$2

if [ -z "$GITHUB_NICKNAME" ] || [ -z "$GITHUB_REPO" ]; then
  echo "Usage: $0 <github_nickname> <github_repo_name>"
  exit 1
fi

# List of files to check.
FILES="README.md CONTRIBUTING.md"

for FILE in $FILES; do
  if [ ! -f "$FILE" ]; then
    echo "❌ File '$FILE' does not exist."
    exit 1
  fi
  # find {github_nickname} or {github_repo} placeholders in file and replace them with args
    if grep -q "{github_nickname}" "$FILE"; then
        sed -i.bak "s/{github_nickname}/$GITHUB_NICKNAME/g" "$FILE"
        rm "$FILE.bak"
    fi
    if grep -q "{github_repo_name}" "$FILE"; then
        sed -i.bak "s/{github_repo_name}/$GITHUB_REPO/g" "$FILE"
        rm "$FILE.bak"
    fi
done