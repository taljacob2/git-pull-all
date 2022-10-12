
: '
Description:
Pull all tracked remote branches from the specified $REMOTE remote.

Parameters:
$1: REMOTE: Optional: Remote name to pull all the branches from.
            The default value is "origin".
'
function gitPullAllTrackedBranches() {

    # Default `$REMOTE` value is "origin".
    REMOTE="${1:-'origin'}"

    HEAD_NAME=$(git symbolic-ref --short HEAD)

    git add . > /dev/null 2>&1
    git stash > /dev/null 2>&1

    for brname in `git branch -r | grep $REMOTE | grep -v /HEAD | awk '{gsub(/^[^\/]+\//,"",$1); print $1}'`; do

        # Check if `$brname` has a tracked remote branch that can be pulled.
        brnameTrackStatus=`git remote show $REMOTE | grep "^    $brname" | grep "merges with remote"`

        if [ ! -z "$brnameTrackStatus" ]; then

            : '
            `$brnameTrackStatus` is NOT empty. Thus `$brname` has a tracked
            remote branch, that can be pulled.
            '
            git checkout branch
            git pull          
        fi
        
    done

    git checkout $HEAD_NAME > /dev/null 2>&1

    git stash pop > /dev/null 2>&1
}

# ---------------------------------- Code -------------------------------------

gitPullAllTrackedBranches "$1"
