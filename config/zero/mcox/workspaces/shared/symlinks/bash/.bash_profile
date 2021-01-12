export LANG="en_US.UTF-8"

my_resize() {
  if [ -x $(which resize 2>/dev/null) ]; then
    eval `resize`
  fi
}

# trap the window change event
trap 'my_resize' WINCH

# set the initial size
my_resize

# Disable brew analytics
export HOMEBREW_NO_ANALYTICS=1

#
# Mac OS X stuff
#
if [[ "$(uname -s)" == "Darwin" ]]; then

    # disable smart quotes
    if [[ $(defaults read NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled) -eq 1 ]]; then
        defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
    fi

    # disable emdash
    if [[ $(defaults read NSGlobalDomain NSAutomaticDashSubstitutionEnabled) -eq 1 ]]; then
        defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
    fi
fi

if [ -r "${HOME}/.dotfiles/alias/bash-like" ]; then
  . "${HOME}/.dotfiles/alias/bash-like"
fi

if [ -d "${HOME}/.dotfiles/path" ]; then
  for X in "${HOME}"/.dotfiles/path/*.sh; do
    . "${X}"
  done
fi

# powerline
if [ -d "${HOME}/.dotfiles/powerline" ]; then
  . "${HOME}/.dotfiles/powerline/powerline/bindings/bash/powerline.sh"
fi
