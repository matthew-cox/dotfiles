#!/usr/bin/env bash

set -o nounset

THE_APP_TO_CLEAN=$1

if [[ -d "${HOME}/Library/Application Support/Fluid/FluidApps/${THE_APP_TO_CLEAN}/" ]]; then
  cd "${HOME}/Library/Application Support/Fluid/FluidApps/${THE_APP_TO_CLEAN}"
  rm --interactive=once -rf LocalStorage/* cookies/cookies DownloadArchive webhistory
else
  echo -e "\a*** Sorry, that app doesn't exist."
fi
