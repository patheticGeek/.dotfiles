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

I'm using [stow]() to manage the symlinks.

This is inspired by https://www.youtube.com/watch?v=tkUllCAGs3c

Each folder in this repo will have its contents (files or folders) places as symlink in the home dir.

So if i have a file and folder such as `zsh/.zshrc`, `zsh/.oh-my-zsh/custom` 

and then run `stow zsh` it will create a symlinks at `~/.zshrc` and `.oh-my-zsh/custom`.

### How to add more stuff

1. Create a folder in this dir
  ```
  mkdir vim
  ```
2. Move the files related to that in the folder
  ```
  mv ~/.vimrc ~/.dotfiles/vim/
  ```
3. Then create the symlink with stow
  ```
  stow vim
  ```

And you're done.