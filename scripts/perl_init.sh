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
if $(command -v perlbrew >/dev/null); then
  source ~/lib/perl5/perlbrew/etc/bashrc
else
  puterr "perlbrew not installed"
  curl -L https://install.perlbrew.pl | bash

  if $(command -v perlbrew >/dev/null); then
    putsuccess "perlbrew installed"
    source ~/lib/perl5/perlbrew/etc/bashrc
  else
    puterr "perlbrew not installed"
    exit 1
  fi
fi

perlbrew install --skip-existing perl-$PERL_VERSION
perlbrew switch perl-$PERL_VERSION
