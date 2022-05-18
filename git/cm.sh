#!/bin/bash

# USE OF THIS SCRIPT: Commit to current branch

verify_not_empty_arg()
{
  if [[ -z "$2" ]]
  then
    echo "There must be a $1"
    exit 1
  else
    echo "$1 $2"
  fi
}

insert_enter()
{
  echo ""
}

insert_enter

verify_not_empty_arg "Commit message" "$1"
#verify_not_empty_arg "Name of branch" "$2"
NAME_BRANCH=$(git rev-parse --abbrev-ref HEAD)
git add .
git commit -am "$1" --no-verify
git push -u origin "$NAME_BRANCH"

insert_enter
