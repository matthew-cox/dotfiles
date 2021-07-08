#!/usr/bin/env bash
# >&2 echo "$0"
# >&2 echo "$PATH"
if [[ -x /usr/libexec/java_home ]]; then
  export JAVA_HOME=$(/usr/libexec/java_home 2>/dev/null)
fi
# >&2 echo "$PATH"
