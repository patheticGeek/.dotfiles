## Geek's dotfiles

### Installation

1. Whichever platform you are on make sure you have `stow` and `git`
2. Clone this repo in home dir
    ```
    git clone https://github.com/patheticGeek/.dotfiles
    ```
3. Run the install script
    ```
    cd ~/.dotfiles
    ./install.sh
    ```

### Some explanation

I'm using _stow_ to manage the symlinks.

This is inspired by https://www.youtube.com/watch?v=tkUllCAGs3c

Each folder in this repo will have its contents (files and folders) placed as symlink in the home dir.

So if i have a file and folder such as `zsh/.zshrc`, `zsh/.oh-my-zsh/custom`

and then run `stow zsh` it will create symlinks at `~/.zshrc` and `~/.oh-my-zsh/custom`.

### How to add more stuff

1. cd into `~/.dotfiles`
2. Create a folder in `~/.dotfiles`
    ```
    mkdir ~/.dotfiles/vim
    ```
3. Move the files related to that in the folder
    ```
    mv ~/.vimrc ~/.dotfiles/vim/
    ```
4. Then create the symlink with stow
    ```
    stow vim
    ```

✨ And you're done

### One liner

```
NAME=
PATH=
mkdir -p ~/.dotfiles/$NAME/$PATH && mv -t ~/.dotfiles/$NAME/$PATH ~/$PATH
```
