#!/usr/bin/env bash
#
# ruby and rbenv
#
# if [ -d "$HOME/.rbenv/shims" ]; then
#   eval "$(rbenv init -)"
# fi
# >&2 echo "$0"
# >&2 echo "$PATH"
if $(command -v rbenv >/dev/null); then
  eval "$(rbenv init -)"
  TM_RUBY="$(command -v ruby)"
fi
# >&2 echo "$PATH"
