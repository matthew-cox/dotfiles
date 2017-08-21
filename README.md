dotfiles
========

the stuff with dots

# First brew some 🍻

Install [Homebrew](https://brew.sh)

Add some taps:

    $ ./scripts/homebrew_init.sh

## Disable analytics

    $ brew analytics off

## Install 1password

    $ brew cask install 1password

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

### Powerline compatibility

    $ cd powerline
    $ git checkout tags/2.1

### Python

Prefer [pyenv](https://github.com/pyenv/pyenv) and [pynenv-virtualenv](https://github.com/pyenv/pyenv-virtualenv) over the global version:

    $ ./scripts/python_init.sh

### Bootstrap

Bootstrap many things with [Cider](https://github.com/msanders/cider):

    $ ln -s ~/.dotfiles/cider ~/.cider
    $ pip install -U cider
    $ yes | cider restore
    $ cider apply-defaults
    $ cider relink

### Mac AppStore Apps

Install the apps from the AppStore:

    # ./scripts/mas_install.sh

### Perl

Prefer [perlbrew](https://github.com/gugod/App-perlbrew) over the global version:

    $ ./scripts/perl_init.sh

Start a new terminal, then:

    $ perlbrew install --skip-existing perl-5.27.2
    $ perlbrew switch perl-5.27.2

### Ruby

Prefer [rbenv](https://github.com/rbenv/rbenv) over the global version:

    $ ./scripts/ruby_init.sh

### SSH config.d

Needs [poet](https://github.com/awendt/poet):

    $ gem install poet
    $ rm -f ~/.ssh/config
    $ poet

### Zsh

Change the user shell:

    $ chsh -s /bin/zsh

Open a new terminal

