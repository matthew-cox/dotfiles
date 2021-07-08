#!/usr/bin/env zsh
#
# List out the network interfaces, types, and IPv4 addresses for Mac OS X
#

emulate -L zsh

function get_addresses(){
  typeset -a addresses

  local type_icon='\uF0AC'

  typeset -A my_net_icons
  my_net_icons[default]='\uF0AC'
  my_net_icons[Ethernet]='\uF6FF'
  my_net_icons[Wi-Fi]='\uF1EB'

  case "$OSTYPE" in
  darwin*)
    ifconfig_cmd='ifconfig'
    if (( $+commands[timeout] )); then
      ifconfig_cmd='timeout --foreground .1s ifconfig'
    fi
    for INTERFACE in $(ifconfig -l); do
      iface_lines=("${(f)$(eval ${ifconfig_cmd} -v $INTERFACE inet)}")

      IP=${(M)iface_lines:#*[[:space:]]broadcast[[:space:]]*}
      if [[ -n "$IP" ]]; then
        IP=("${(@s< >)IP}")
        TYPE=${(M)iface_lines:#*[^:]*type:[[:space:]]*}
        TYPE=("${(@s< >)TYPE}")
        type_icon=${my_net_icons[$TYPE[2]]}
        addresses+=("$IP[2] ${type_icon:=\uF0AC}")
      fi
    done
    ;;
  Linux)
    for INTERFACE in $(ifconfig -s | tail -n +2 | awk '{print $1}'); do
      IP=$(ifconfig "${INTERFACE}" | grep 'broadcast' | awk '{print $2}')
      if [[ -n "$IP" ]]; then
        TYPE=$(ifconfig -v "${INTERFACE}" | grep '^[^:]*type:' | awk -F ': ' '{print $2}')
        type_icon=${my_net_icons[$TYPE]}
        addresses+=("$IP[2] ${type_icon:=\uF0AC}")
      fi
    done
    ;;
  esac

  ADDRESS_STRING=${(j< | >)addresses}
}

local ADDRESS_STRING
get_addresses
print $ADDRESS_STRING
