## Downloading on a newly installed system

- _Step 1_: Clone this repo, and create git directory `.dotfiles`.

```bash
$ git clone --separate-git-dir=~/.dotfiles https://github.com/Anindya-ctrl/.dotfiles.git ~
```

_Optional_ (if cloning doesn't work due to home directory already having some files):

```bash
$ mkdir temp
$ git clone --separate-git-dir=~/.dotfiles https://github.com/Anindya-ctrl/.dotfiles.git temp
$ rsync --recursive --verbose --exclude '.git' temp/ ~
$ rm -rf ~/temp
```

- _Step 2_: Create alias for future use.

```bash
$ alias dotfiles='git --git-dir=~/.dotfiles/ --work-tree=~'
# or, on fish
$ alias --save dotfiles='git --git-dir=~/.dotfiles/ --work-tree=~'
```

- _Step 3_: Disable untracked files on status.

```bash
$ dotfiles config --local status.showUntrackedFiles no
```

## Screenshots

![image 1](https://images2.imgbox.com/ef/6e/YudAA8zE_o.png)
![image 1](https://images2.imgbox.com/0e/92/hsPoq9rl_o.png)
![image 1](https://images2.imgbox.com/a7/72/oCicjAOX_o.png)
![image 1](https://images2.imgbox.com/e0/52/11strJHm_o.png)
