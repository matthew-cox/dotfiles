#
# misc homebrew keg only paths
#
KEG_PATHS=(
# sqlite
"/usr/local/opt/sqlite/bin"
# gpg-agent
"/usr/local/opt/gpg-agent/bin"
)

for keg_path in "${KEG_PATHS[@]}"; do
  if [[ -d "$keg_path" ]]; then
    # echo "$keg_path"
    export PATH="/usr/local/opt/sqlite/bin:$PATH"
  fi
done
