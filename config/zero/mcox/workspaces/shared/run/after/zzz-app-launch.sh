#!/usr/bin/env bash
#
# Launch macOS apps to complete installation
#
# set -x
WORKDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" || exit; pwd -P)
SCRIPTDIR="${HOME}/.dotfiles/scripts"
readonly WORKDIR SCRIPTDIR
#
##############################################################################
#
# Load some utilities
#
readonly THE_UTILS=( "common" )

for utility in "${THE_UTILS[@]}"; do
  if [[ -r "${SCRIPTDIR}/utils_${utility}.sh" ]]; then
    source "${SCRIPTDIR}/utils_${utility}.sh"
  fi
done

_apps_to_start=(
"Alfred 4"
"Bartender 4"
"Docker"
"Fantastical"
# "Itsycal"
"KeepingYouAwake"
"Little Snitch"
"Plexamp"
"Rectangle"
"SlimBatteryMonitor"
"SoundSource"
"Stay"
"Todoist"
"TripMode"
"TunnelBear"
)

readonly _apps_to_start


for _app in "${_apps_to_start[@]}"; do

  _app_dir="/Applications/${_app}.app/Contents/MacOS/"

  if [[ -d "${_app_dir}" ]]; then
    _app_launch="$(has_binary_been_launched "$(find "${_app_dir}" -type f)")"
    if [[ "${_app_launch}" == "false" ]]; then
      # putinfo "Would launch '${_app}"
      open -a "${_app}"
      sleep 5
    fi
  fi
done
