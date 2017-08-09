#!/usr/bin/env bash
#
#
set -o errexit -o pipefail -o nounset
. "$(dirname "$0")/common.sh"
#
##############################################################################
#
# Desired ruby version
#
export RUBY_VERSION=2.4.1
# ???
# export RBENV_ROOT=/usr/local/var/rbenv
if $(command -v rbenv >/dev/null); then
    eval "$(rbenv init -)";
else
    puterr "rbenv not installed"
    brew install rbenv

    if $(command -v rbenv >/dev/null); then
      putsuccess "rbenv installed"
      eval "$(rbenv init -)"
    else
      puterr "rbenv not installed"
      exit 1
    fi
fi

echo "Updating Ruby..."
rbenv install "${RUBY_VERSION}" --skip-existing
rbenv global "${RUBY_VERSION}"
gem update --system
