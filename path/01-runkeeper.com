if [ -d "/usr/local/rk/bin" ]; then
  export PATH="${PATH}:/usr/local/rk/bin:/usr/local/rk/sbin"
fi
