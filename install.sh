#!/usr/bin/env bash

set -e

function stow {
  command stow -t "$HOME" -v "$1"
}

function guess_target {
  if which pacman >/dev/null 2>&1; then
    # arch linux
    echo bin_arch cli gui
  elif which yum >/dev/null 2>&1; then
    # centos/rhel/fedora
    echo at_work bash-ldap cli
  else
    # other
    echo cli
  fi
}

readonly targets=${*:-$(guess_target)}

for target in $targets; do
  case $target in
    at_work)
      touch ~/.at_work
      ;;
    bash-ldap)
      backup_bashrc
      if [ -f "$HOME/.bashrc" ]; then
        mv "$HOME/.bashrc" "$HOME/.bashrc.backup.$(date +%F_%R)"
      fi
      stow bash-ldap
      ;;
    bin_arch)
      mkdir -p ~/bin
      stow bin-arch
      ;;
    cli)
      stow git
      stow nvim
      stow tmux
      stow zsh
      ;;
    gui)
      stow xmodmap
      stow awesome
      stow termite
      stow udiskie
      ;;
    *)
      echo "Unknown target $target" 2>&1
      exit 1
      ;;
  esac
done
