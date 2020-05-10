#!/usr/bin/env sh

append_to_path() {
  local dir re
  for dir; do
    re="(^dir:|:$dir:|:$dir$)"
    if ! [[ $PATH =~ $re ]]; then
      export PATH="$PATH:$dir"
    fi
  done
}

# cargo (rust)
append_to_path "${HOME}/.cargo/bin"

# go
export GOPATH="${HOME}/Workspace/go"
append_to_path "${GOPATH}/bin"

# local installs
append_to_path "${HOME}/.local/bin"

# linuxbrew, support local and system-wide
if [ -e "/home/linuxbrew" ]; then
  append_to_path "/home/linuxbrew/.linuxbrew/bin"
elif [ -e "${HOME}/.linuxbrew" ]; then
  append_to_path "${HOME}/.linuxbrew/bin"
fi

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
