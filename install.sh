#!/usr/bin/env bash

function stow {
  command stow -t $HOME -v $1
}

stow awesome
stow git
stow nvim
stow termite
stow tmux
stow vim
stow zsh
