#!/usr/bin/env bash
#
# remove quarantine from an app
#
set -o nounset

THE_APP_TO_FIX="$1"

if [[ -d "/Applications/${THE_APP_TO_FIX}/" ]]; then
  xattr -rd com.apple.quarantine "/Applications/${THE_APP_TO_FIX}/"
elif [[ -d "${THE_APP_TO_FIX}" ]]; then
  xattr -rd com.apple.quarantine "${THE_APP_TO_FIX}/"
else
  echo -e "\a*** Sorry, that app doesn't exist."
fi
