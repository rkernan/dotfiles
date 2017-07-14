#!/usr/bin/env bash

function stow {
  command stow -t $HOME -v $1
}

stow git
stow nvim
stow tmux
stow vim
stow zsh
