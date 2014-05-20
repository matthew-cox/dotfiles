# postgresql on Mac OS X
if [ "$(uname -s)" = "Darwin" ]; then
  for X in 9.3 9.2 9.1; do
    if [ -d "/Library/PostgreSQL/${X}/bin" ]; then
      export PATH="/Library/PostgreSQL/${X}/bin:${PATH}"
    fi
  done
fi