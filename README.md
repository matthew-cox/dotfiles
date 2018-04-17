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

    $ xcode-select --install

# Brew some 🍻

Install [Homebrew](https://brew.sh):

    $ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

## Disable analytics

    $ brew analytics off

## Install 1password

    $ brew tap caskroom/cask
    $ brew cask install 1password

## Install MAS

    $ brew install mas
    # Sign in with your Apple ID
    $ mas signin your-email@apple.id.com

## Basic github configure

Find `GitHub_rsa.priv` in 1password and install at `~/.ssh/GitHub_rsa.priv`; then:

    $ chmod 400 ~/.ssh/GitHub_rsa.priv

Configure a very basic `~/.ssh/config`:

    $ echo -e "Host *github.com\n    IdentityFile ~/.ssh/GitHub_rsa.priv\n" > ~/.ssh/config

# Get the dots

    $ git clone https://github.com/matthew-cox/dotfiles.git .dotfiles
    $ cd .dotfiles/
    $ git submodule init
    $ git submodule update

## Powerline compatibility

    $ cd powerline
    $ git checkout tags/2.1

## Python

Prefer [pyenv](https://github.com/pyenv/pyenv) and [pyenv-virtualenv](https://github.com/pyenv/pyenv-virtualenv) over the global version:

    $ ./scripts/python_init.sh

## Bootstrap

Bootstrap many things with [Cider](https://github.com/msanders/cider):

    $ ln -s ~/".dotfiles/cider/${USER}" ~/.cider
    $ pip install -U cider
    $ yes | cider restore
    $ cider apply-defaults
    $ cider relink

## Mac AppStore Apps

Install the apps from the AppStore:

    # ./scripts/mas_install.sh

## Perl

Prefer [perlbrew](https://github.com/gugod/App-perlbrew) over the global version:

    $ ./scripts/perl_init.sh

Start a new terminal, then:

    $ perlbrew install --skip-existing perl-5.27.2
    $ perlbrew switch perl-5.27.2

## Ruby

Prefer [rbenv](https://github.com/rbenv/rbenv) over the global version:

    $ ./scripts/ruby_init.sh

## SSH

### config.d

Needs [poet](https://github.com/awendt/poet):

    $ gem install poet
    $ rm -f ~/.ssh/config
    $ poet

### Key Symlinks

    $ ln -s ~/.ssh/simplisafe/PrdCommon.pem ~/.ssh/

## TextMate

Install TextMate bundle manager and bundles:

    $ ./scripts/textmate_init.sh

## Zsh

Change the user shell:

    $ chsh -s /bin/zsh

## Revel in your configured environment

Open a new terminal:

    $ open /Applications/iTerm2.app

