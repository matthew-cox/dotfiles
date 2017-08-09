#!/usr/bin/env bash
#
#
set -o errexit -o pipefail -o nounset
. "$(dirname "$0")/common.sh"
#
# Define taps for tapping
#
declare -a TAPS=(
"caskroom/cask"
)
#
#
#
if ! $(command -v brew >/dev/null); then
    puterr "Homebrew not installed"
    exit 1
fi

for tap in "${TAPS[@]}"; do
  echo -n "Tapping '$tap'..."
  brew tap "${tap}"
  echo "done"
done
