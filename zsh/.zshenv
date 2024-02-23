if [ -f $HOME/.cargo/env ]; then
  . "$HOME/.cargo/env"
fi

if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
