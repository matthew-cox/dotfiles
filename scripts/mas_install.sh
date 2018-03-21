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
readonly THE_UTILS=( "common" )

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
readonly CONFIG_DIR="${HOME}/.dotfiles/config/mas"
DEFAULT_CONFIG_FILE="${CONFIG_DIR}/default.sh"
if [[ -r "${DEFAULT_CONFIG_FILE}" ]]; then
  source "${DEFAULT_CONFIG_FILE}"
fi

#
# define and load MAS app config file
#
USER_CONFIG_FILE="${CONFIG_DIR}/${USER}/config.sh"
if [[ -r "${USER_CONFIG_FILE}" ]]; then
  source "${USER_CONFIG_FILE}"
fi

# Might need this if running under tmux
# || echo ensures we don't fail in the event reattach-to-user-namespace is missing
user_namespace_attach="$(command -v reattach-to-user-namespace 2>/dev/null || echo)"

if [[ $(command -v mas) ]]; then
  for APP in "${MAS_APPS[@]}"; do
    putinfo "Installing '${APP}'..."
    if [[ -n "${user_namespace_attach:-}" ]]; then
      $user_namespace_attach mas install $APP
    else
      mas install $APP
    fi
    putinfo "Done"
  done
else
  puterror "mas command not found"
  exit 1
fi
