#!/usr/bin/env bash
#
# user stuff
#
# >&2 echo "$0"
# >&2 echo "$PATH"
export PATH="./bin:${HOME}/bin:${PATH}"
# >&2 echo "$PATH"

# unhide the Library directory
if [[ "$(uname -s)" == "Darwin" ]]; then
  chflags nohidden ~/Library
fi

# if [ -d "${HOME}/.dotfiles/bin" ]; then
#   export PATH="${PATH}:${HOME}/.dotfiles/bin"
# fi

#
# prefer gnu tools rather than OS X
#
gnu_bin_dir="/usr/local/opt/coreutils/libexec/gnubin"
if [[ -d "${gnu_bin_dir}" ]]; then
  in_path=$(echo "$PATH" | grep -c "${gnu_bin_dir}")
  if [[ $in_path -le 0 ]]; then
    export PATH="${gnu_bin_dir}:${PATH}"
    export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
  else
    # >&2 echo "already in path"
    # >&2 echo "$PATH"
    export PATH="${gnu_bin_dir}:$(echo $PATH | sed -e 's|'${gnu_bin_dir}'||' | sed -e 's/:://g')"
    # >&2 echo "$PATH"
  fi
fi
