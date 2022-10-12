> v1.0.0

# git-pull-all

## Installation

### Clone This Repository As A Subtree In Your Project

Merge this repository to a new folder called `git-pull-all` at the root folder of your project:
```
git subtree add -P git-pull-all https://github.com/taljacob2/git-pull-all master --squash
```

### Configure The Alias Of `git pull-all`

Run the following command:
```
git config alias.pull-all '!sh ./git-pull-all/git-pull-all.sh "${args[@]}"'
```

## How To Use

```
git pull-all [REMOTE-NAME]
```

## Check For Updates

In case you already have an existing version of "git-pull-all" and you want to update to the newest version available, you can merge the newest version of this repository to your existing `git-pull-all` folder:
```
git subtree pull -P git-pull-all https://github.com/taljacob2/git-pull-all master --squash
```
