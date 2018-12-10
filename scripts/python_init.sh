#!/usr/bin/env bash
#
#
set -o errexit -o pipefail -o nounset
# set -x
WORKDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" || exit; pwd -P)
export PYENV_VIRTUALENV_DISABLE_PROMPT=true
export PROMPT_COMMAND=bananas
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
# config stuff
#
readonly CONFIG_DIR="${HOME}/.dotfiles/config/python"
DEFAULT_CONFIG_FILE="${CONFIG_DIR}/default.sh"
if [[ -r "${DEFAULT_CONFIG_FILE}" ]]; then
  source "${DEFAULT_CONFIG_FILE}"
fi
#
# define and load config file
#
USER_CONFIG_FILE="${CONFIG_DIR}/${USER}/config.sh"
if [[ -r "${USER_CONFIG_FILE}" ]]; then
  source "${USER_CONFIG_FILE}"
fi

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
if $(command -v pyenv-virtualenv-init >/dev/null); then
  eval "$(pyenv virtualenv-init -)"
else
  puterr "virtualenv not installed"
  brew install pyenv-virtualenv

  if $(command -v pyenv-virtualenv-init >/dev/null); then
    putsuccess "virtualenv installed"
  else
    puterr "virtualenv not installed"
    exit 1
  fi
fi

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
pyenv install --skip-existing $PYENV_VERSION
if $(pyenv versions --bare | grep python-local-${PYENV_VERSION} &> /dev/null); then
  putsuccess "virtual environment 'python-local-${PYENV_VERSION}' already exists."
else
  pyenv virtualenv $PYENV_VERSION python-local-${PYENV_VERSION}
fi
pyenv shell python-local-${PYENV_VERSION}
pyenv which pip

# ensure that pip and setuptools are new
putinfo "Upgrading pip and setuptools..."
pip install --upgrade pip setuptools
putsuccess "done"

USER_PIP_FILE="${CONFIG_DIR}/${USER}/pip.txt"
if [[ -r "${USER_PIP_FILE}" ]]; then
  pip install -r "${USER_PIP_FILE}"
fi

