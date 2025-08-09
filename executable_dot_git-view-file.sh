#!/bin/bash

# Function to display usage
usage() {
  echo "Usage: gfileexplore [-f] <file-path>"
  echo "  -f    Fetch all branches before listing"
  echo "  <file-path>    The path to the file you want to explore"
  exit 1
}

# Parse command-line options
fetch=false
while getopts "f" opt; do
  case $opt in
    f)
      fetch=true
      ;;
    *)
      usage
      ;;
  esac
done

# Shift the processed options away
shift $((OPTIND-1))

# Get the file path
file_path=$1

# Check if file path is provided
if [ -z "$file_path" ]; then
  usage
fi

# Fetch branches if the -f flag is provided
if $fetch; then
  git fetch --all
fi

# Get the list of branches
branches=$(git branch -r --sort=-committerdate)

# Check if there are branches available
if [ -z "$branches" ]; then
  echo "No branches available."
  exit 1
fi

# Use fzf to select a branch with file content preview
selected_branch=$(echo "$branches" | fzf --ansi --no-sort --preview="git show {1}:$file_path" --preview-window=right:60%:wrap)

# Check if a branch was selected
if [ -z "$selected_branch" ]; then
  echo "No branch selected."
  exit 1
fi

# Remove any leading whitespace and remote prefix from the selected branch
selected_branch=$(echo "$selected_branch" | sed 's/^ *//' | sed 's|^origin/||')

# Switch to the selected branch
git checkout "$selected_branch"

# Output the file content
cat "$file_path"
