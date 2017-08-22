#!/usr/bin/env bash
#
# allow admin users to disable services without a password
#
echo "*** Creating sudo config..."
sudo sh -c 'echo "
#
# allow admin users to disable services without a password
#
%admin          ALL = (root) NOPASSWD: /bin/launchctl disable *
%admin          ALL = (root) NOPASSWD: /bin/launchctl stop *
%admin          ALL = (root) NOPASSWD: /usr/bin/pkill -9 keyboardservicesd
" > /private/etc/sudoers.d/10-service-control'