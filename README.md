## Downloading on a newly installed system
- *Step 1*: Clone this repo, and create git directory `.dotfiles`.
```bash
$ git clone --separate-git-dir=~/.dotfiles https://github.com/Anindya-ctrl/.dotfiles.git ~
```
*Optional* (if cloning doesn't work due to home directory already having some files):
```bash
$ mkdir temp
$ git clone --separate-git-dir=~/.dotfiles https://github.com/Anindya-ctrl/.dotfiles.git temp
$ rsync --recursive --verbose --exclude '.git' temp/ ~
$ rm -rf ~/temp
```

- *Step 2*: Create alias for future use.
```bash
$ alias dotfiles='git --git-dir=~/.dotfiles/ --work-tree=~'
# or, on fish
$ alias --save dotfiles='git --git-dir=~/.dotfiles/ --work-tree=~'
```

- *Step 3*: Disable untracked files on status.
```bash
$ dotfiles config --local status.showUntrackedFiles no
```
