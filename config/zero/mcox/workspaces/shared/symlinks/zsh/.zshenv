#
# Can't set PATH here because /etc/zprofile clobbers it
#

# Disable brew analytics
export HOMEBREW_NO_ANALYTICS=1

# increase open file limit
ulimit -n 10240
