#!/usr/bin/env bash
#
# set -x
WORKDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" || exit; pwd -P)
#
##############################################################################
#
# Load some utilities
#
readonly RUBY_UTILS=( "common" )

for utility in "${RUBY_UTILS[@]}"; do
  if [[ -r "${WORKDIR}/utils_${utility}.sh" ]]; then
    source "${WORKDIR}/utils_${utility}.sh"
  fi
done
##############################################################################
#
# Desired ruby version
#
readonly LOCAL_RUBY_VERSION=2.4.1
# readonly LOCAL_RUBY_VERSION=2.3.4
export LOCAL_RUBY_VERSION
#
##############################################################################
#
# ruby_check() - Look for a non-global ruby
#
ruby_check() {

  rbenv=$(rbenv_check; exit 0)
  rvm=$(rvm_check; exit 0)
  
  if [[ $rbenv -eq 0 || $rvm -eq 0 ]]; then
    putsuccess "Some non-global Ruby configured!"
  else
    puterr "Cannot configure a global ruby!"
    exit 7
  fi
}
export -f ruby_check
#
##############################################################################
#
# rbenv_check() - Look for a local rbenv ruby
#
rbenv_check() {

  exit_code=0
  local_ruby=$(command -v ruby 2>/dev/null | grep -c "shims")

  if [[ $local_ruby -ne 1 ]]; then
    # user does not have a local ruby, setup rbenv?
    puterr "Ruby seems to be the global version. You should NOT use the global version!"
  fi

  if ! command -v rbenv >/dev/null; then
    puterr "Rbenv is not installed! Cowardly refusing to proceed..."
    exit_code=7
  else
    eval "$(rbenv init -)";
    RBENV_GLOBAL="$(rbenv global 2>/dev/null)"
    if [[ -z "${RBENV_GLOBAL}" || "$RBENV_GLOBAL" != "${LOCAL_RUBY_VERSION}" ]]; then
      putinfo "Installing local Ruby v${LOCAL_RUBY_VERSION}..."
      rbenv install "${LOCAL_RUBY_VERSION}" --skip-existing
      putinfo "Registering local Ruby..."
      rbenv global "${LOCAL_RUBY_VERSION}"
      putinfo "Updating gems..."
      gem update --system
      rbenv bundler on
      exit_code=0
    fi

    if [[ "$SHELL" == "/bin/bash" ]]; then
      RBENV_INIT_CONFIGURED=$(grep 'rbenv init -' ~/.bash_profile | wc -l; exit 0)
      if [[ $RBENV_INIT_CONFIGURED -ne 1 ]]; then
        putinfo "Configuring rbenv for interactive bash shells..."
        cat <<EOF >> ~/.bash_profile
#
# Add rbenv
#
eval "\$(rbenv init -)"
rbenv bundler on
EOF
      fi
    else
      puterr "Don't know how to configure your shell '$SHELL'..."
      puterr "Add the following lines to the correct profile file for your shell:"
      puterr '\neval "$(rbenv init -)"\nrbenv bundler on\n'
    fi

  fi
  echo "$exit_code"
}
export -f ruby_check
#
##############################################################################
#
# rvm_check() - Look for rvm supplied ruby (NOTE: doesn't work)
#
rvm_check() {
  exit_code=1
  local_ruby=$(command -v ruby 2>/dev/null | grep -c "shims")

  if [[ $local_ruby -ne 1 ]]; then
    # user does not have a local ruby, setup rvm?
    puterr "Ruby seems to be the global version. You should NOT use the global version!"
    exit_code=1
  fi
  echo "$exit_code"
}
export -f rvm_check
#
##############################################################################
#
# ruby_check_gem() - Verify that specified gems are installed
#
ruby_check_gem() {
  LOCAL_GEMS=$(gem list --local)

  for gem in "$@"; do
    gem_installed=$(echo "$LOCAL_GEMS" | grep "^$gem" | wc -l; exit 0)
    if [[ $gem_installed -ne 1 ]]; then
      putinfo "Gem '$gem' is NOT installed; installing..."
      gem install "$gem"
      putsuccess "Done!"
    fi
  done
}
export -f ruby_check_gem
