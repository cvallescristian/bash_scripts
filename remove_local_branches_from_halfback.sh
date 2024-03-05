#!/bin/bash

used_branches=(
  "develop"
  "staging"
  "production"
  "feature/FBDEV-77-testing-rails"
  "backup/12-feb-2024"
  "release/11-october-2023"
  "release/8-may-2023"
  "release/7-august-2023"
  "feature/payment-method"
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
git_repo_path="/Users/cristian/Projects/fashion-biz/halfback"
cd $git_repo_path || exit
git checkout develop
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


