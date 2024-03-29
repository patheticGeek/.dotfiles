## Geek's dotfiles

### Installation

1. Whichever platform you are on make sure you have `stow` and `git`

   For ubuntu `sudo apt install git stow`

2. Clone this repo in home dir
   ```
   git clone https://github.com/patheticGeek/.dotfiles
   ```
3. Run the install script
   ```
   cd .dotfiles && ./dotfiles.sh setup
   ```
   The folders to be used are stored in `dotfiles_folders`. It is a space separated list.

Now `./dotfiles.sh` script will also be available as `dotfiles` as it is aliased in shell.

### Some explanation

I'm using _stow_ to manage the symlinks and _git_ to version and backup.

This is inspired by https://www.youtube.com/watch?v=tkUllCAGs3c

Each folder in this repo will have its contents (files and folders) placed as symlink in the home dir.

So if i have a file and folder such as `zsh/.zshrc`, `zsh/.oh-my-zsh/custom`

and then run `stow zsh` it will create symlinks at `~/.zshrc` and `~/.oh-my-zsh/custom`.

The `personal` folder is a submodule, it is a private repo where i have my _personal_ keys and stuff.

### How to add/delete more stuff

Can do so via `dotfiles [add|delete] FOLDER FILE` command. e.g.

```bash
# Will add file at correct path to others folder
dotfiles add others ~/.config/mimeapps.list
```

```bash
# Will remove file from others folder and put it at original path
dotfiles delete others ~/.config/mimeapps.list
```

### `dotfiles` command help

Run
