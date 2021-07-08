#!/usr/bin/env bash
#
# Fix old, busted brew casks:
# https://github.com/Homebrew/homebrew-cask/issues/58046
#
/usr/bin/find "$(brew --prefix)/Caskroom/"*'/.metadata' -type f -name '*.rb' -print0 | \
  /usr/bin/xargs -0 /usr/bin/perl -i -pe 's/depends_on macos: \[.*?\]//gsm;s/depends_on macos: .*//g'
