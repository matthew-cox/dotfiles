#!/usr/bin/env bash

brew install pyenv pyenv-virtualenv
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

export PYENV_VERSION=2.7.13

pyenv install --skip-existing $PYENV_VERSION
pyenv virtualenv $PYENV_VERSION python-local-${PYENV_VERSION}

pyenv which pip

pip install -r ./pip.txt
