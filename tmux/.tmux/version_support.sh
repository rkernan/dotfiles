#!/usr/bin/env bash

export TMUX_VERSION="$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")"

source_config() {
  local tmux_home="${HOME}/.tmux"

  if [[ $(echo "$TMUX_VERSION >= 2.1" | bc) -eq 1 ]]; then
    tmux source-file "${tmux_home}/tmux.conf"
  else
    tmux source-file "${tmux_home}/tmux_old.conf"
  fi
}

source_config
