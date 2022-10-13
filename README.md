> v1.0.0

# git-pull-all

An addition for `git pull`, to be able to pull at once all the *local* branches
that are being tracked by *remote* branches. So the user won't have to manually
`git checkout` & `git pull` them one by one.

## Why Use `git pull-all`

In case your project contains multiple branches that are constantly updating
remotely and you want to `git fetch` and `git pull` them all at once,
then this tool will save you the effort for doing so manually.

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
git pull-all [<repository>]
```

> `<repository>` is the "remote" repository that is the source of a fetch or pull operation. This parameter can be either a URL or the name of a remote. The default value is `origin`.

## Check For Updates

In case you already have an existing version of "git-pull-all" and you want to update to the newest version available, you can merge the newest version of this repository to your existing `git-pull-all` folder:
```
git subtree pull -P git-pull-all https://github.com/taljacob2/git-pull-all master --squash
```
