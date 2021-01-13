# dotfiles

the stuff with dots

**Last Updated: 2018-03-21 16:54 @matthew-cox**

Table of Contents
=================
  * [dotfiles](#dotfiles)
  * [Xcode CLI Tools](#xcode-cli-tools)
  * [Brew some 🍻](#brew-some-)
    * [Disable analytics](#disable-analytics)
    * [Install 1password](#install-1password)
    * [Install MAS](#install-mas)
    * [Basic github configure](#basic-github-configure)
  * [Get the dots](#get-the-dots)
    * [Powerline compatibility](#powerline-compatibility)
    * [Python](#python)
    * [Bootstrap](#bootstrap)
    * [Mac AppStore Apps](#mac-appstore-apps)
    * [Perl](#perl)
    * [Ruby](#ruby)
    * [SSH](#ssh)
      * [config.d](#configd)
      * [Key Symlinks](#key-symlinks)
    * [TextMate](#textmate)
    * [Zsh](#zsh)
    * [Revel in your configured environment](#revel-in-your-configured-environment)

# Xcode CLI Tools

A pre-req for most of this is the Xcode tools. One should be able to install them:

    ❯ xcode-select --install

# Brew some 🍻

Install [Homebrew](https://brew.sh):

    ❯ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

## Disable analytics

    ❯ brew analytics off

## Install 1password

    ❯ brew tap homebrew/cask
    ❯ brew install --cask 1password 1password-cli

## Basic github configure

Find `GitHub_rsa.priv` in 1password and install at `~/.ssh/GitHub_rsa.priv`; then:

    ❯ mkdir -p ~/.ssh; chmod 755 ~/.ssh
    ❯ eval $(op signin cox_ponting_towers)
    ❯ op get document 'GitHub_rsa.priv - github.com (matthew-cox)' > ~/.ssh/GitHub_rsa.priv
    ❯ op signout cox_ponting_towers
    ❯ chmod 400 ~/.ssh/GitHub_rsa.priv

Configure a very basic `~/.ssh/config`:

    ❯ echo -e "Host *github.com\n    IdentityFile ~/.ssh/GitHub_rsa.priv\n" > ~/.ssh/config

# Get the dots

    ❯ git clone --recurse-submodules git@github.com:matthew-cox/dotfiles.git .dotfiles

## Bootstrap

Bootstrap many things with [Zero.sh](https://github.com/msanders/zero.sh):

    ❯ ./scripts/zero_init.sh [home|work]

## Python

Prefer [pyenv](https://github.com/pyenv/pyenv) and [pyenv-virtualenv](https://github.com/pyenv/pyenv-virtualenv) over the global version:

    ❯ ./scripts/python_init.sh

## Perl

Prefer [perlbrew](https://github.com/gugod/App-perlbrew) over the global version:

    ❯ ./scripts/perl_init.sh

Start a new terminal, then:

    ❯ perlbrew install --switch perl-5.32.0

## Ruby

Prefer [rbenv](https://github.com/rbenv/rbenv) over the global version:

    ❯ ./scripts/ruby_init.sh

## SSH

### config.d

SSH configs are in Keybase git repo:

    ❯ open /Applications/Keybase.app
    ❯ git clone keybase://private/mcox/ssh_config ~/.ssh/config.d

Needs [poet](https://github.com/awendt/poet) to generate:

    ❯ gem install poet
    ❯ rm -f ~/.ssh/config
    ❯ poet

### Key Symlinks

    ❯ mkdir -p ~/.ssh/simplisafe
    ❯ op get document uuid1 > ~/.ssh/simplisafe/QaCommon.pem
    ❯ op get document uuid2 > ~/.ssh/simplisafe/StgCommon.pem
    ❯ op get document uuid3 > ~/.ssh/simplisafe/PrdCommon.pem
    ❯ chmod 400 ~/.ssh/simplisafe/*.pem
    ❯ for X in ~/.ssh/simplisafe/*.pem; do ln -s $X ~/.ssh/$(basename $X); done

## TextMate

Install TextMate bundle manager and bundles:

    ❯ ./scripts/textmate_init.sh

## Revel in your configured environment

Open a new terminal:

    ❯ new_iterm_window

