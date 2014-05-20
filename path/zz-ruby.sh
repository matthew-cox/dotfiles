# ruby / rvm shite
if [ -d "$HOME/.gem/ruby/1.8/bin" ]; then
  export PATH="${HOME}/.gem/ruby/1.8/bin:${PATH}"
fi

###[[ -s "/Users/mcox/.rvm/scripts/rvm" ]] && source "/Users/mcox/.rvm/scripts/rvm"  # This loads RVM into a shell session