#!/usr/bin/env bash

function backup_bashrc {
  if [ -f "$HOME/.bashrc" ] && [ ! -L "$HOME/.bashrc" ]; then
    mv "$HOME/.bashrc" "$HOME/.bashrc.backup.$(date +%F_%R)"
  fi
}

function stow {
  command stow -t "$HOME" -v "$1"
}

function install_cli_config {
  stow git
  stow nvim
  stow tmux
  stow zsh
}

function install_gui_config {
  stow awesome
  stow termite
}

function install_ldap_fixes {
  backup_bashrc
  stow bash-ldap
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
  work)
    install_cli_config
    install_ldap_fixes
    ;;
  *)
    echo "Unknown target $target" 2>&1
    exit 1
    ;;
esac
