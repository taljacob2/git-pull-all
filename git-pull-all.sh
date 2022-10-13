#!/bin/bash

: '
Description:
Pull all tracked remote branches from the specified $REMOTE remote.

Parameters:
$1: REMOTE: Optional: Remote name to pull all the branches from.
            The default value is "origin".
'
function gitPullAllTrackedBranches() {

    # Default `$REMOTE` value is "origin".
    REMOTE="${1:-origin}"

    # Log print.
    echo "Fetching all '$REMOTE' tracked branches..."

    git fetch $REMOTE

    # In case `git fetch` did not succeed, then exit.
    status=$?
    [ $status -ne 0 ] && exit "$status"

    echo

    # Log print.
    echo "Pulling all '$REMOTE' tracked branches..."

    HEAD_NAME=$(git symbolic-ref --short HEAD)

    git add . > /dev/null 2>&1
    git stash > /dev/null 2>&1

    # Get all branches as a long string.
    branchesAsString=`git branch | tr -d '\*' | sed 's/^[ \t]*//'`

    # Convert `$branchesAsString` to a list of branches.    
    mapfile -t branches <<< "$branchesAsString"

    for brname in "${branches[@]}"; do

        # Check if `$brname` has a tracked remote branch that can be pulled.
        brnameTrackStatus=`git remote show $REMOTE | grep "^    $brname" | grep "merges with remote"`

        if [ ! -z "$brnameTrackStatus" ]; then

            : '
            `$brnameTrackStatus` is NOT empty. Thus `$brname` has a tracked
            remote branch, that can be pulled.
            '
            echo
            
            git checkout $brname
            git pull
        fi
        
    done

    echo

    git checkout $HEAD_NAME

    git stash pop > /dev/null 2>&1
}

# ---------------------------------- Code -------------------------------------

gitPullAllTrackedBranches "$1"
