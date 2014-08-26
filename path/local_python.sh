# tell python about our stuff
if [ "${HOME}/lib/python2.7/site-packages" ]; then
  export PYTHONPATH="${HOME}/lib/python2.7/site-packages/:$PYTHONPATH:"
fi

# look for pyenv - and set it up
if [ -r "${HOME}/.pyenv" ]; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi

# add pip installed bins to the path
if [ -x "$(which pyenv 2>/dev/null)" ]; then
  PYPATH="$(dirname $(pyenv which python))"
  export PATH="$PYPATH:$PATH"
fi
