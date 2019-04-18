#!/usr/bin/env sh

# pyenv
export PATH="${HOME}/.pyenv/bin:${PATH}"
# pip
export PATH="$HOME/.local/bin:${PATH}"
# rust
export PATH="$HOME/.cargo/bin:${PATH}"
# go
export GOPATH="${HOME}/dev/go"
export PATH="${GOPATH}/bin:${PATH}"
# npm
export NPM_PACKAGES="${HOME}/.npm-packages"
export PATH="${NPM_PACKAGES}/bin:${PATH}"
# user bin
export PATH="$HOME/bin:${PATH}"

export EDITOR="nvim"
export VISUAL="$EDITOR"
export PAGER="less"
