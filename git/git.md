# git

## GPG

```git
// configure global gpg
git config --global user.signingkey MY_KEY_ID

// configure gpg
git config user.signingkey MY_KEY_ID

// auth sign gpg commit
git config commit.gpgsign true

// print gpg keys
gpg --list-secret-keys --keyid-format LONG
```

## Worktree

```git
git worktree add ../folder name-of-branch
git worktree list
git worktree prune
```

To fix `fatal: '' is already checked out at ''`

`rm -rf .git/worktrees/`

## Unsorted

```git
// Squash
git rebase -i <SHA1 after this commit + THIS COMMIT>

// Squash from HEAD by 3 commits
// HEAD -> 1 -> 2 -> was squashed from there
git rebase -i HEAD~3

// git tag - add
git tag 2.0.0
git push --tags

// git tag - delete
 git tag -d 2.0.0
git push origin :refs/tags/2.0.0

// rebase
// remove all my changes, pull from master
git rebase --onto master

// save my changes, pull from master, applying my changes
git rebase master

// remove cache
git rm --cached <file>
git rm -r --cached <directory>

// discard changes on file
git checkout -- <filename>

// configure repo .gitconfig
git config user.name "Your Name Here" --replace-all
git config user.email your@email.com

// configure repo .gitconfig with replace all usernames (use if error)
git config user.name "Your Name Here" --replace-all

// configure global .gitconfig
git config --global user.name "Your Name Here"
git config --global user.email your@email.com

// to up to date upstream github repository
git remote add <name> <ssh or url>
git <name> fetch
git merge <name>/<branch_name>
```