#!/usr/bin/env bash

export PYENV_VERSION=2.7.13

pyenv install --skip-existing $PYENV_VERSION

pyenv which pip

pip install -r ./pip.txt
