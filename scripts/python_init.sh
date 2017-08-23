#!/usr/bin/env bash
#
#
set -o errexit -o pipefail -o nounset
# set -x
WORKDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" || exit; pwd -P)
#
##############################################################################
#
# Load some utilities
#
readonly THE_UTILS=( "common" )

for utility in "${THE_UTILS[@]}"; do
  if [[ -r "${WORKDIR}/utils_${utility}.sh" ]]; then
    source "${WORKDIR}/utils_${utility}.sh"
  fi
done
#
##############################################################################
#
# Desired python version
#
export PYENV_VERSION=2.7.13
#
##############################################################################
#
# pyenv
#
if $(command -v pyenv >/dev/null); then
  eval "$(pyenv init -)"
else
  puterr "pyenv not installed"
  brew install pyenv

  if $(command -v pyenv >/dev/null); then
    putsuccess "pyenv installed"
    eval "$(pyenv init -)"
  else
    puterr "pyenv not installed"
    exit 1
  fi
fi
#
##############################################################################
#
# virtualenv
#
if $(command -v virtualenv >/dev/null); then
  eval "$(pyenv virtualenv-init -)"
else
  puterr "virtualenv not installed"
  brew install virtualenv

  if $(command -v virtualenv >/dev/null); then
    putsuccess "virtualenv installed"
  else
    puterr "virtualenv not installed"
    exit 1
  fi
fi

pyenv install --skip-existing $PYENV_VERSION
pyenv virtualenv $PYENV_VERSION python-local-${PYENV_VERSION}

pyenv which pip

pip install -r ../pip.txt
