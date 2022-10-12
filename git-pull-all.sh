
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

    # DEBUG
    echo "DEBUG REMOTE: $REMOTE"

    HEAD_NAME=$(git symbolic-ref --short HEAD)

    git add . > /dev/null 2>&1
    git stash > /dev/null 2>&1

    branches=`git branch | tr -d '\*' | sed 's/^[ \t]*//'`
    for brname in "${branches[@]}"; do

        # DEBUG
        echo "DEBUG brname: $brname"

        # Check if `$brname` has a tracked remote branch that can be pulled.
        brnameTrackStatus=`git remote show $REMOTE | grep "^    $brname" | grep "merges with remote"`

        if [ ! -z "$brnameTrackStatus" ]; then

            : '
            `$brnameTrackStatus` is NOT empty. Thus `$brname` has a tracked
            remote branch, that can be pulled.
            '
            git checkout $brname
            git pull
        fi
        
    done

    git checkout $HEAD_NAME > /dev/null 2>&1

    git stash pop > /dev/null 2>&1
}

# ---------------------------------- Code -------------------------------------

gitPullAllTrackedBranches "$1"
