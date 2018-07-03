#!/usr/bin/env bash
# >&2 echo "$0"
# >&2 echo "$PATH"
# tell python about our stuff
# if [ "${HOME}/lib/python2.7/site-packages" ]; then
#   export PYTHONPATH="${HOME}/lib/python2.7/site-packages/:$PYTHONPATH"
# fi

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

# Work around for High Sierra Python fork crashes
# https://github.com/ansible/ansible/issues/32499
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# add pip installed bins to the path
# if $(command -v pyenv >/dev/null 2>&1); then
#   PYPATH="$(dirname $(pyenv which python))"
#   export PATH="$PYPATH:$PATH"
# fi
# >&2 echo "$PATH"
