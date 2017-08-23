#!/usr/bin/env bash
#
# allow admin users to disable services without a password
#
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

putinfo "Creating sudo config..."
sudo sh -c 'echo "
#
# allow admin users to disable services without a password
#
%admin          ALL = (root) NOPASSWD: /bin/launchctl disable *
%admin          ALL = (root) NOPASSWD: /bin/launchctl stop *
%admin          ALL = (root) NOPASSWD: /usr/bin/pkill -9 keyboardservicesd
" > /private/etc/sudoers.d/10-service-control'
