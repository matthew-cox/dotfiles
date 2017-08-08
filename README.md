dotfiles
========

the stuff with dots

# First brew some :beers:

(Homebrew)[https://brew.sh]
(Homebrew cask)[https://caskroom.github.io]

## Disable analytics

    $ brew analytics off

# Get the dots

    $ git clone https://github.com/matthew-cox/dotfiles.git .dotfiles
    $ cd .dotfiles/
    $ git submodule init
    $ git submodule update
    
### Powerline compatibility

    $ cd powerline
    $ git checkout tags/2.1

### SSH config.d

Needs poet:

    $ sudo gem install poet
    $ . alias/bash-like
    $ poet

### Python

    $ ./python_init.sh

### Zsh

    $ ln -s .dotfiles/zsh/zshrc .zshrc
    $ ln -s .dotfiles/zsh/zprofile .zprofile
    $ chsh -s /bin/zsh

### Brew restore

    $ ln -s ~/.dotfiles/cider ~/.cider
    $ pip install -U cider
    $ yes | cider restore


