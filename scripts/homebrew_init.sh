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
readonly THE_UTILS=( "common" "homebrew" )

for utility in "${THE_UTILS[@]}"; do
  if [[ -r "${WORKDIR}/utils_${utility}.sh" ]]; then
    source "${WORKDIR}/utils_${utility}.sh"
  fi
done
#
##############################################################################
#
# Homebrew
#
putinfo "Checking Homebrew..."
brew_install
#
# Define taps for tapping - only add Cask to allow bootstrapping with 1password
#
declare -a TAPS=(
"caskroom/cask"
)

for tap in "${TAPS[@]}"; do
  putinfo "Tapping '$tap'..."
  brew tap "${tap}"
  putsuccess "done"
done
