#!/bin/bash

used_branches=(
  "main"
  "staging"
  "collection-staging"
)

function check_if_branch_is_used {
  local branch=$1
  found=false

  for used_branch in "${used_branches[@]}"; do
    if [ $used_branch == $branch ]; then
      found=true
      break
    fi
  done
}

# Go to the repo path
git_repo_path="/Users/cristian/Projects/fashion-biz/bizz-react"
cd $git_repo_path || exit
git checkout main
echo "using directory: $(pwd)"

# get an array of branches
branches=$(git branch | cut -c 3- )
list_of_local_branches=()
while IFS= read -r branch; do
    list_of_local_branches+=("$branch")
done <<< "$branches"

# Check if branches is not used, then deleted it.
for branch in "${list_of_local_branches[@]}"; do
  check_if_branch_is_used $branch

  if [ "$found" == false ]; then
    git branch -D $branch
  fi
done


