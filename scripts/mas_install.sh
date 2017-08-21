#!/usr/bin/env bash
#
# Initialize Mas App Store apps
#
set -o errexit -o pipefail -o nounset
# set -x
WORKDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" || exit; pwd -P)
#
##############################################################################
#
# Load some utilities
#
readonly THE_UTILS=( "common" "mas" )

for utility in "${THE_UTILS[@]}"; do
  if [[ -r "${WORKDIR}/utils_${utility}.sh" ]]; then
    source "${WORKDIR}/utils_${utility}.sh"
  fi
done
#
##############################################################################
#
# "Global" variables
#
MAS_APPS=(
  # Deliveries (3.0.3)
  924726344
  # Display Menu (2.2.2)
  549083868
  # LastPass (3.22.2)
  926036361
  # Moom (3.2.9)
  419330170
  # MuteMyMic (1.10)
  456362093
  # Radium (3.1.3)
  597611879
  # Slack (2.7.1)
  803453959
  # UnPlugged (3.0)
  423123087
  # Wunderlist (3.4.7)
  410628904
  # Xcode (8.3.3)
  497799835
  # properVOLUME (1.1.4)
  521142667
)

# need this if running under tmux
user_namespace_attach="$(command -v reattach-to-user-namespace 2>/dev/null)"

if [[ $(command -v mas) ]]; then
  for APP in "${MAS_APPS[@]}"; do
    if [[ -n "${user_namespace_attach:-}" ]]; then
      $user_namespace_attach mas install $APP
    else
      mas install $APP
    fi
  done
fi
