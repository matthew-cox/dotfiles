# tell python about our stuff
if [ "${HOME}/lib/python2.7/site-packages" ]; then
  export PYTHONPATH="${HOME}/lib/python2.7/site-packages/:$PYTHONPATH"
fi

# look for pyenv - and set it up
if $(command -v pyenv >/dev/null); then
  export PYENV_ROOT="$HOME/.pyenv"
  # export PATH="$HOME/.pyenv/bin:$PATH"
  eval "$(pyenv init -)"
fi

# look for pyenv-virtualenv - and set it up
if $(command -v pyenv-virtualenv-init >/dev/null); then
  export PYENV_VIRTUALENV_DISABLE_PROMPT=true
  eval "$(pyenv virtualenv-init -)"
  # export PYTHONPATH="$(pyenv prefix)/lib/python2.7:$PYTHONPATH"
  # alias powerline="$(pyenv prefix)/bin/powerline"
fi

# add pip installed bins to the path
# if $(command -v pyenv >/dev/null 2>&1); then
#   PYPATH="$(dirname $(pyenv which python))"
#   export PATH="$PYPATH:$PATH"
# fi
