#!/usr/bin/env sh

# cargo (rust)
export PATH="${HOME}/.cargo/bin:${PATH}"

# go
export GOPATH="${HOME}/workspace/go"
export PATH="${GOPATH}/bin:${PATH}"

# local installs (pip, nodejs)
export PATH="${HOME}/.local/bin:${PATH}"

# linuxbrew, support local and system-wide
if [ -e "/home/linuxbrew" ]; then
  export PATH="/home/linuxbrew/.linuxbrew/bin:${PATH}"
elif [ -e "${HOME}/.linuxbrew" ]; then
  export PATH="${HOME}/.linuxbrew/bin:${PATH}"
fi

# user bin
export PATH="${HOME}/bin:${PATH}"

export EDITOR="nvim"
export VISUAL="$EDITOR"
export PAGER="less"

# doesn't work in putty... disable for now
if [ -e "${HOME}/.at_work" ]; then
  # putty can't dislay the unicode properly, use simple symbols
  export ZSH_PROMPT_MODE=">"
  export ZSH_PROMPT_VICMD_MODE="<"
fi

# always run tmux
export ZSH_TMUX_AUTOSTART=1