#!/bin/bash
if [ "$(uname -s)" = "Darwin" ]; then
  defaults write com.apple.dashboard mcx-disabled -boolean YES
  killall Dock
fi
