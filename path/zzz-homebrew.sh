#!/usr/bin/env bash
#
# Homebrew path
#
BIN_PATHS=(
"/usr/local/bin"
"/usr/local/sbin"
)

for bin_path in "${BIN_PATHS[@]}"; do
  if [[ ! ($PATH =~ "${bin_path}") ]]; then
    export PATH="${PATH}:${bin_path}"
  fi
done
#
# misc homebrew keg only paths
#
# >&2 echo "$0"
# >&2 echo "$PATH"

KEG_PATHS=(
"/usr/local/opt/bison/bin"
"/usr/local/opt/go/libexec/bin"
"/usr/local/opt/gpg-agent/bin"
"/usr/local/opt/icu4c/bin"
"/usr/local/opt/icu4c/sbin"
"/usr/local/opt/libxml2/bin"
"/usr/local/opt/openssl@1.1"
"/usr/local/opt/sqlite/bin"
"/usr/local/opt/openjdk/bin"
)
#
# paths for compiling things
#
BUILD_PATHS=(
"bison"
"icu4c"
"libxml2"
"openjdk"
"openssl@1.1"
"qt"
"sqlite"
"zlib"
)
#
# keg only binary paths
#
for keg_path in "${KEG_PATHS[@]}"; do
  if [[ -d "$keg_path" ]]; then
    in_path=$(echo "$PATH" | grep -c "${keg_path}")
    # echo "$keg_path"
    if [[ $in_path -le 0 ]]; then
      export PATH="${keg_path}:$PATH"
    fi
  fi
done
# >&2 echo "$PATH"
#
# build env variables
#
for build_path in "${BUILD_PATHS[@]}"; do
  if [[ -d "/usr/local/opt/${build_path}/lib" ]]; then
    export LDFLAGS="${LDFLAGS} -L/usr/local/opt/${build_path}/lib"
  fi
  if [[ -d "/usr/local/opt/${build_path}/include" ]]; then
    export CPPFLAGS="${CPPFLAGS} -I/usr/local/opt/${build_path}/include"
  fi
  if [[ -d "/usr/local/opt/${build_path}/lib/pkgconfig" ]]; then
    export PKG_CONFIG_PATH="/usr/local/opt/${build_path}/lib/pkgconfig:${PKG_CONFIG_PATH}"
  fi
done
#
# Enable brew command-not-found
#
if brew command command-not-found-init > /dev/null 2>&1; then
  eval "$(brew command-not-found-init)";
fi
