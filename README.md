dotfiles
========

the stuff with dots

#To Use
 
    git clone https://github.com/matthew-cox/dotfiles.git .dotfiles
    cd .dotfiles/
    git submodule init
    git submodule update
    
###Powerline compatibility

    cd powerline
    git checkout tags/2.1

### SSH config.d

Needs poet:

    sudo gem install poet
    . alias/bash-like
    poet
