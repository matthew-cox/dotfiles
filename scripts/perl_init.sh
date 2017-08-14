#!/usr/bin/env bash
#
#
set -o errexit -o pipefail -o nounset
. "$(dirname "$0")/common.sh"
#
##############################################################################
#
# Desired perl version
#
export PERL_VERSION=5.27.2
#
##############################################################################
#
# perlbrew
#
export PERLBREW_ROOT="${HOME}/lib/perl5/perlbrew"

if [[ -f "${PERLBREW_ROOT}/etc/bashrc" ]]; then
  source "${PERLBREW_ROOT}/etc/bashrc"
fi

if $(command -v perlbrew >/dev/null); then
  source "${PERLBREW_ROOT}/etc/bashrc"
else
  puterr "perlbrew not installed"
  curl -L https://install.perlbrew.pl | bash
  perlbrew init
fi

echo "Start a new terminal window and execute the following: "
echo "perlbrew install --skip-existing perl-$PERL_VERSION"
echo "perlbrew switch perl-$PERL_VERSION"
