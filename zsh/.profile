#!/usr/bin/env sh

# cargo (rust)
export PATH="${HOME}/.cargo/bin:${PATH}"

# go
export GOPATH="${HOME}/workspace/go"
export PATH="${GOPATH}/bin:${PATH}"

# pyenv
export PATH="${HOME}/.pyenv/bin:${PATH}"

# local installs (pip, nodejs)
export PATH="${HOME}/.local/bin:${PATH}"

# user bin
export PATH="${HOME}/bin:${PATH}"

export EDITOR="nvim"
export VISUAL="$EDITOR"
export PAGER="less"
