#!/bin/bash
if [ "$(uname -s)" = "Darwin" ]; then
  defaults write -g com.apple.trackpad.scaling 2.5
fi
