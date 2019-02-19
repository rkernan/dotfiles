#!/usr/bin/env bash

set -e

function stow {
  command stow -t "$HOME" -v "$1"
}

function guess_target {
  if which pacman >/dev/null 2>&1; then
    # arch linux
    echo bin-arch cli gui pyenv
  elif which yum >/dev/null 2>&1; then
    # centos/rhel/fedora - work
    echo bash-ldap cli pyenv
  else
    # other
    echo cli pyenv
  fi
}

function install_pyenv {
  # install pyenv
  readonly pyenv_root="$HOME/.pyenv"
  if [ ! -d "$pyenv_root" ]; then
    git clone https://github.com/pyenv/pyenv.git "$pyenv_root"
    PATH="${pyenv_root}:${PATH}"
  fi
  # install pyenv-virtualenv
  if [ ! -d "$(pyenv root)/plugins/pyenv-virtualenv" ]; then
    git clone https://github.com/pyenv/pyenv-virtualenv.git "$(pyenv root)/plugins/pyenv-virtualenv"
  fi
  # install pyenv-update
  if [ ! -d "$(pyenv root)/plugins/pyenv-update" ]; then
    git clone http://github.com/pyenv/pyenv-update.git "$(pyenv root)/plugins/pyenv-update"
  fi
  # init - needs to be done after pyenv-virtualenv install
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
  # update
  pyenv update
  # setup neovim2
  readonly python2_ver="2.7.15"
  if [ ! -d "$(pyenv root)/versions/${python2_ver}" ]; then
    pyenv install "$python2_ver"
  fi
  readonly neovim2_env="neovim2"
  rm -f "$(pyenv root)/versions/${neovim2_env}"
  rm -rf "$(pyenv root)/versions/${python2_ver}/envs/${neovim2_env}"
  pyenv virtualenv "$python2_ver" "$neovim2_env"
  pyenv activate "$neovim2_env"
  pip install pynvim
  pip install neovim
  # setup neovim3
  readonly python3_ver="3.7.2"
  if [ ! -d "$(pyenv root)/versions/${python3_ver}" ]; then
    pyenv install "$python3_ver"
  fi
  readonly neovim3_env="neovim3"
  rm -f "$(pyenv root)/versions/${neovim3_env}"
  rm -rf "$(pyenv root)/versions/${python3_ver}/envs/${neovim3_env}"
  pyenv virtualenv "$python3_ver" "$neovim3_env"
  pyenv activate "$neovim3_env"
  pip install pynvim
  pip install neovim
}

readonly targets=${*:-$(guess_target)}

# always make bin dir
mkdir -p ~/bin

for target in $targets; do
  case $target in
    bash-ldap)
      if [ -L "$HOME/.bashrc" ]; then
        rm -f "$HOME/.bashrc"
      elif [ -f "$HOME/.bashrc" ]; then
        mv "$HOME/.bashrc" "$HOME/.bashrc.backup.$(date +%F_%R)"
      fi
      stow bash-ldap
      ;;
    bin-arch)
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
    pyenv)
      install_pyenv
      ;;
    *)
      echo "Unknown target $target" 2>&1
      exit 1
      ;;
  esac
done
