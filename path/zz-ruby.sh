#
# ruby and rbenv
#
# if [ -d "$HOME/.rbenv/shims" ]; then
#   eval "$(rbenv init -)"
# fi

if $(command -v rbenv >/dev/null); then
  eval "$(rbenv init -)"
  TM_RUBY="$(command -v ruby)"
fi
