# perlbrew
if [ -d "${HOME}/lib/perl5/perlbrew" ]; then
  export PERLBREW_ROOT="${HOME}/lib/perl5/perlbrew"
  source ${PERLBREW_ROOT}/etc/bashrc
fi

# old stuff???
#if [ -d "${HOME}/lib/perl5/lib/perl5" ]; then
#  eval $(perl -I${HOME}/lib/perl5/lib/perl5 -Mlocal::lib=${HOME}/lib/perl5)
#fi

# cpanm??
#export PERL_CPANM_OPT="--prompt --reinstall -l ~/lib/perl5 --mirror http://cpan.cpantesters.org"