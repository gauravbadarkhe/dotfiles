#!/bin/bash

# Function to display usage
usage() {
  echo "Usage: gswitch [-f]"
  echo "  -f    Fetch all branches before listing"
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

# Fetch branches if the -f flag is provided
if $fetch; then
  git fetch --all --prune
fi

# Get the list of branches, remove 'remotes/' prefix for cleaner display
branches=$(git branch -a --sort=-committerdate | sed 's#remotes/##')

# Check if there are branches available
if [ -z "$branches" ]; then
  echo "No branches available."
  exit 1
fi

# Use fzf to select a branch with preview of recent commits
selected_branch=$(echo "$branches" | fzf --ansi --no-sort \
  --preview="git log --graph --pretty=format:'%C(yellow)%h%Creset %C(cyan)%cd%Creset %C(auto)%d%Creset %C(bold blue)<%an>%Creset %s' --date=short --color=always {1}" \
  --preview-window=right:60%:wrap)

# Check if a branch was selected
if [ -z "$selected_branch" ]; then
  echo "No branch selected."
  exit 1
fi

# Clean up the selected branch name (remove leading *, whitespace)
selected_branch=$(echo "$selected_branch" | sed 's/^[* ]*//' | xargs)

# Check if it's a remote branch
if [[ "$selected_branch" == origin/* ]]; then
  local_branch=${selected_branch#origin/}
  git checkout -B "$local_branch" --track "origin/$local_branch"
else
  git checkout "$selected_branch"
fi


# #!/bin/bash
#
# # Function to display usage
# usage() {
#   echo "Usage: gswitch [-f]"
#   echo "  -f    Fetch all branches before listing"
#   exit 1
# }
#
# # Parse command-line options
# fetch=false
# while getopts "f" opt; do
#   case $opt in
#     f)
#       fetch=true
#       ;;
#     *)
#       usage
#       ;;
#   esac
# done
#
# # Fetch branches if the -f flag is provided
# if $fetch; then
#   git fetch --all
# fi
#
# # Get the list of branches
# branches=$(git branch -a --sort=-committerdate)
#
# # Check if there are branches available
# if [ -z "$branches" ]; then
#   echo "No branches available."
#   exit 1
# fi
#
# # Use fzf to select a branch with commit list preview
# selected_branch=$(echo "$branches" | fzf --ansi --no-sort --preview="git log --graph --pretty=format:'%C(yellow)%h%Creset %C(cyan)%cd%Creset %C(auto)%d%Creset %C(bold blue)<%an>%Creset %s' --date=short --color=always {1}" --preview-window=right:60%:wrap)
#
# # Check if a branch was selected
# if [ -z "$selected_branch" ]; then
#   echo "No branch selected."
#   exit 1
# fi
#
# # Remove any leading whitespace and asterisk from the selected branch
# selected_branch=$(echo "$selected_branch" | sed 's/^* //' | xargs)
#
# # Switch to the selected branch
# git checkout "$selected_branch"
