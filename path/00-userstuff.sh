#!/usr/bin/env bash
#
# user stuff
#
export PATH="./bin:${HOME}/bin:${PATH}"

# unhide the Library directory
if [[ "$(uname -s)" == "Darwin" ]]; then
  chflags nohidden ~/Library
fi

# if [ -d "${HOME}/.dotfiles/bin" ]; then
#   export PATH="${PATH}:${HOME}/.dotfiles/bin"
# fi
