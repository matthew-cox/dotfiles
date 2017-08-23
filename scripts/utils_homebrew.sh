#!/usr/bin/env bash
#
# Collection of Mac OS X homebrew related things
#
###############################################################################
#
# Load some utilities
#
readonly BREW_UTILS=( "common" )

for utility in "${BREW_UTILS[@]}"; do
  if [[ -r "${WORKDIR}/utils_${utility}.sh" ]]; then
    source "${WORKDIR}/utils_${utility}.sh"
  fi
done
#
##############################################################################
#
# find Mac OS X / macOS
#
case $(uname -s) in
  Darwin)
    readonly MACOSX=true
  ;;
  *)
    readonly MACOSX=false
  ;;
esac
export MACOSX
#
##############################################################################
#
# brew_cask() - Check the status of Homebrew Cask
#
brew_cask() {
  #
  # NOTE: Adding Homebrew Cask for native Mac apps - https://caskroom.github.io/
  #
  if [[ $MACOSX == true ]]; then
    brew_check
    # using wc to avoid grepc -c exit codes
    CASK_TAPPED="$(brew tap 2>/dev/null | grep 'caskroom/cask' | wc -l; exit 0)"
    if [[ $CASK_TAPPED -eq 0 ]]; then
      brew tap caskroom/cask 2> /dev/null
    fi
  fi
}
export -f brew_cask
#
##############################################################################
#
# brew_check() - Check the status of Homebrew
#
brew_check() {
  if [[ $MACOSX == true ]]; then
    # Check if command exists with `command`:
    # http://stackoverflow.com/a/677212/125305
    if [[ ! $(command -v brew) ]]; then
      puterr 'Homebrew needed! Install Homebrew, then re-run your command.'
      putinfo 'https://brew.sh/'
      exit 1
    fi
  fi
}
export -f brew_check
#
##############################################################################
#
# brew_check_cask() - Return 0 if package is installed, 1 otherwise
#
brew_check_cask() {
  local the_package="$1"
  local installed=1
  if [[ $MACOSX == true ]]; then
    # Check for package - using wc to avoid grepc -c exit codes
    installed=$(brew cask info "$the_package" 2>&1 | grep '^Not installed' | wc -l; exit 0)
  fi
  echo $installed
}
export -f brew_check_cask
#
##############################################################################
#
# brew_install() - Install Homebrew
#
brew_install() {
  if [[ $MACOSX == true ]]; then
    # Check if command exists with `command`:
    # http://stackoverflow.com/a/677212/125305
    if [[ ! $(command -v brew) ]]; then
      putinfo 'Installing Homebrew...'
      /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
  fi
}
export -f brew_install
#
##############################################################################
#
# brew_install_cask_if_missing() - Install packages if they are not installed
#
brew_install_cask_if_missing(){
  if [[ $MACOSX == true ]]; then
    for package in "$@"; do
      # Check for package
      CASK_STATUS=$(brew_check_cask "$package")
      if [[ $CASK_STATUS -ne 0 ]]; then
          putinfo "Installing '$package'..."
          brew cask install "$package"
      fi
    done
  fi
}
export -f brew_install_cask_if_missing
#
##############################################################################
#
# brew_install_or_upgrade_cask() - Install a package or upgrade it
#
brew_install_or_upgrade_cask(){
  if [[ $MACOSX == true ]]; then
    for package in "$@"; do
      # Check for package
      PACKAGE_STATUS=$(brew_check_cask "$package")
      if [[ $PACKAGE_STATUS -ne 0 ]]; then
        putinfo "Installing '$package'..."
        brew cask install "$package"
      else
        putinfo "Upgrading '$package'..."
        brew cask upgrade --cleanup "$package"
      fi
    done
  fi
}
export -f brew_install_or_upgrade_cask
#
##############################################################################
#
# brew_check_package() - Return 0 if package is installed, 1 otherwise
#
brew_check_package() {
  local the_package="$1"
  local installed=1
  if [[ $MACOSX == true ]]; then
    # Check for package - using wc to avoid grep -c exit codes
    installed=$(brew info "$the_package" 2>&1 | grep '^Not installed' | wc -l; exit 0)
  fi
  echo $installed
}
export -f brew_check_package
#
##############################################################################
#
# brew_install_if_missing() - Install packages if they are not installed
#
brew_install_if_missing(){
  if [[ $MACOSX == true ]]; then
    for package in "$@"; do
      # Check for package
      PACKAGE_STATUS=$(brew_check_package "$package")
      if [[ $PACKAGE_STATUS -ne 0 ]]; then
        brew install "$package"
      fi
    done
  fi
}
export -f brew_install_if_missing
#
##############################################################################
#
# brew_install_or_upgrade() - Install a package or upgrade it
#
brew_install_or_upgrade(){
  if [[ $MACOSX == true ]]; then
    for package in "$@"; do
      # Check for package
      PACKAGE_STATUS=$(brew_check_package "$package")
      if [[ $PACKAGE_STATUS -ne 0 ]]; then
        brew install "$package"
      else
        brew upgrade --cleanup "$package"
      fi
    done
  fi
}
export -f brew_install_or_upgrade
