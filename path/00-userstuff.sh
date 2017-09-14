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

# Prefer the Homebrew installed openssl (new hotness)
if [[ -d "/usr/local/opt/openssl" ]]; then
  export LDFLAGS="-L/usr/local/opt/openssl/lib"
  export CPPFLAGS="-I/usr/local/opt/openssl/include"
fi
