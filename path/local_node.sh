#!/usr/bin/env bash

# look for nodenv - and set it up
if $(command -v nodenv >/dev/null); then
  eval "$(nodenv init -)"
fi
