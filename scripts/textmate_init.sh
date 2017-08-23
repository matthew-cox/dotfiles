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
readonly THE_UTILS=( "common" "ruby" )

for utility in "${THE_UTILS[@]}"; do
  if [[ -r "${WORKDIR}/utils_${utility}.sh" ]]; then
    source "${WORKDIR}/utils_${utility}.sh"
  fi
done
#
##############################################################################
#
# global vars
#
GEMS=(
"tmbundle-manager"
)

TM_BUNDLES=(
"elia/avian-missing"
"mitsuhiko/jinja2-tmbundle"
"streeter/markdown-redcarpet.tmbundle"
)
#
##############################################################################
#
# Install the bundle manager
#
ruby_check_gem "${GEMS[@]}"
#
# Install the bundles
#
if command -v tmb >/dev/null; then
  for BUNDLE in "${TM_BUNDLES[@]}"; do
    putinfo "Installing '${BUNDLE}'..."
    tmb install "$BUNDLE"
    putsuccess "Done!"
  done
  tmb update
else
  puterr "TextMate bundle manager is not installed!"
fi
