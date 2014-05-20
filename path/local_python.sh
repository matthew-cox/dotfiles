# tell python about our stuff
if [ "${HOME}/lib/python2.7/site-packages" ]; then
  export PYTHONPATH="$PYTHONPATH:${HOME}/lib/python2.7/site-packages/"
fi

# add pip installed bins to the path
if [ -x $(which pyenv) ]; then
  PYPATH=$(dirname $(pyenv which python))
  export PATH="$PYPATH:$PATH"
fi