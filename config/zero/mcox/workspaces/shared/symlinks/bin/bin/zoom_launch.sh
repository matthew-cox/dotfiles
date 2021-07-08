#!/usr/bin/env bash

readonly _meeting_url="${1}"
readonly _zoom_app='zoom.us'

function validate_url() {
  local _test_url="${1}"
  local result=-1

  if [[ -n "${_test_url}" && "${_test_url}" =~ ^https:// && "${_test_url}" =~ .zoom.us/ ]]; then
    result=0
  fi

  return $result
}

if $(validate_url "${_meeting_url}"); then
  case "$(uname -s)" in
  Darwin)
    open -a ${_zoom_app} "${_meeting_url}"
    ;;
  esac
fi
