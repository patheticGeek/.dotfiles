# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="geek"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

DISABLE_UNTRACKED_FILES_DIRTY="true"

ZSH_CUSTOM="$HOME/.omz-geek"

plugins=(git nvm python vscode docker docker-compose adb zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

bindkey -v

if [ -f ~/.aliasesrc ]; then
    source ~/.aliasesrc
fi

export LANG=en_US.UTF-8
export LC_ALL=en_US.utf-8

export EDITOR='vim'

export ARCHFLAGS="-arch x86_64"

export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:~/go/bin

export DENO_INSTALL="~/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

export JAVA_HOME="/usr/lib/jvm/java-17-openjdk"
export PATH=$PATH:$JAVA_HOME
export ANDROID_HOME=~/Android/Sdk
export PATH=$PATH:$ANDROID_HOME
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH=$PATH:~/.cabal/bin/

if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

export PATH=~/.local/share/JetBrains/Toolbox/scripts:$PATH

export PATH=/opt/cuda/bin:$PATH
export LD_LIBRARY_PATH="/opt/cuda/lib64:$LD_LIBRARY_PATH"

# pnpm
export PNPM_HOME="~/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end
