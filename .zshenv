if [[ -x /usr/libexec/path_helper &&  -z "$TMUX" ]]; then
  eval `/usr/libexec/path_helper -s`
fi
