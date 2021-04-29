#!/usr/bin/env zsh
#
# Executes commands at the start of an interactive session.
#
# echo "zshrc - $PATH"
#
# Command history stuff
#
HISTFILE=${HOME}/.zsh_history
HISTSIZE=5000
#
##############################################################################
#
# completions - https://stackoverflow.com/questions/26462667/git-completion-not-working-in-zsh-on-os-x-yosemite-with-homebrew#26479426
#
if [[ -d /usr/local/share/zsh-completions ]]; then
  fpath=(/usr/local/share/zsh-completions "${fpath[@]}")
fi
#
# if [[ -d /usr/local/share/zsh/site-functions ]]; then
#   fpath=(/usr/local/share/zsh/site-functions "${fpath[@]}")
# fi

# moar completions
if [[ -d "${HOME}/.zsh-functions" ]]; then
  fpath=(${HOME}/.zsh-functions "${fpath[@]}")
fi

if [[ -d "${HOME}/.dotfiles/zsh/completion.d" ]]; then
  fpath=(${HOME}/.dotfiles/zsh/completion.d "${fpath[@]}")
fi

autoload -U compinit && compinit
zmodload -i zsh/complist

#
##############################################################################
#
# zsh plugins
#
if [[ -d "${HOME}/.dotfiles/zsh/plugins/" ]]; then
  setopt EXTENDED_GLOB
  for plugin in "${HOME}"/.dotfiles/zsh/plugins/*/*.zsh; do
    # echo "$plugin"
    if [[ -r "${plugin}" ]]; then
      source "${plugin}"
    fi
  done
fi

# I dunno - TextMate rbenv support maybe?
# if [ -d "${HOME}/.dotfiles/path/zz-ruby.sh" ]; then
#     source "${HOME}/.dotfiles/path/zz-ruby.sh"
# fi
#
##############################################################################
#
# zplug
#
export ZPLUG_HOME=/usr/local/opt/zplug
# if [[ -f "${ZPLUG_HOME}/init.zsh" ]]; then
#     source $ZPLUG_HOME/init.zsh
# fi

#
##############################################################################
#
# iterm integration
#
if [[ -f "${HOME}/.dotfiles/zsh/iterm2_shell_integration.zsh" ]]; then
  source "${HOME}/.dotfiles/zsh/iterm2_shell_integration.zsh"
fi
#
##############################################################################
#
# powerlevel10k
#
powerlevel_dir="${HOME}/.dotfiles/powerlevel10k"
if [[ -d "${powerlevel_dir}" ]]; then
  source "${powerlevel_dir}/powerlevel10k.zsh-theme"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
#
##############################################################################
#
# powerline
#
powerline_dir="${HOME}/.dotfiles/powerline"
# if [[ -d "${powerline_dir}" ]]; then
#
#   # performance?
#   if command -v powerline-daemon >/dev/null; then
#     powerline-daemon -q
#   fi
#
#   in_path=$(echo "$PATH" | grep -c "${powerline_dir}")
#   if [[ $in_path -le 0 ]]; then
#     export PATH="${PATH}:${powerline_dir}/scripts"
#     # this breaks python > 3.4 from a conflict with the selectors module
#     # export PYTHONPATH="${PYTHONPATH}:${HOME}/.dotfiles/powerline/powerline:${HOME}/.dotfiles/powerline/powerline/lib"
#   fi
#   source "${HOME}/.dotfiles/powerline/powerline/bindings/zsh/powerline.zsh"
# fi
#
##############################################################################
#
# zsh-syntax highlighting
#
if [[ -f "/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
  # export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/usr/local/share/zsh-syntax-highlighting/highlighters
  source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
