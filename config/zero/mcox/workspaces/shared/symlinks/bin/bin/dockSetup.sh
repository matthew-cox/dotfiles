#!/usr/bin/env bash

if [[ "$(uname -s)" = "Darwin" ]]; then
  defaults write com.apple.dock pinning -string end
  defaults write com.apple.dock no-glass -boolean YES
  killall Dock
fi
