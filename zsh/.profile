#!/usr/bin/env sh

# pyenv
export PATH="${HOME}/.pyenv/bin:${PATH}"
# pip
export PATH="$HOME/.local/bin:${PATH}"
# go
export GOPATH="${HOME}/workspace/go"
export PATH="${GOPATH}/bin:${PATH}"
# cargo (rust)
export PATH="${HOME}/.cargo/bin:${PATH}"
# user bin
export PATH="$HOME/bin:${PATH}"

export EDITOR="nvim"
export VISUAL="$EDITOR"
export PAGER="less"
