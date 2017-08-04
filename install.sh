#!/usr/bin/env bash

function stow {
  command stow -t $HOME -v $1
}

function install_cli_config {
  stow git
  stow nvim
  stow tmux
  stow vim
  stow zsh
}

function install_gui_config {
  stow awesome
  stow termite
}

readonly target=${1:-all}

case $target in
  all)
    install_cli_config
    install_gui_config
    ;;
  cli)
    install_cli_config
    ;;
  gui)
    install_gui_config
    ;;
  *)
    echo "Unknown target $target" 2>&1
    exit 1
    ;;
esac
