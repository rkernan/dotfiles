#!/usr/bin/env bash

set -e

readonly python2_ver="2.7.15"
readonly python3_ver="3.7.2"

function stow {
  command stow -t "$HOME" -v "$1"
}

guess_target() {
  if which pacman >/dev/null 2>&1; then
    # arch linux
    echo bin-arch cli gui pyenv neovim
  elif which apt-get >/dev/null 2>&1; then
    # ubuntu/linux-subsystem
    echo bash-to-zsh cli pyenv neovim
  elif which yum >/dev/null 2>&1; then
    # centos/rhel/fedora - work
    echo bin-arch cli gui pyenv neovim
  else
    # other
    echo cli pyenv neovim
  fi
}

setup_pyenv() {
  # install pyenv
  local pyenv_root="$HOME/.pyenv"
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
}

setup_neovim_venv() {
  # setup neovim2 virtualenv
  if [ ! -d "$(pyenv root)/versions/${python2_ver}" ]; then
    pyenv install "$python2_ver"
  fi
  local neovim2_env="neovim2"
  if [ ! -d "$(pyenv root)/versions/${neovim2_env}" ]; then
    pyenv virtualenv "$python2_ver" "$neovim2_env"
  fi
  pyenv activate "$neovim2_env"
  pip install -U pynvim neovim
  # setup neovim3 virtualenv
  if [ ! -d "$(pyenv root)/versions/${python3_ver}" ]; then
    pyenv install "$python3_ver"
  fi
  local neovim3_env="neovim3"
  if [ ! -d "$(pyenv root)/versions/${neovim3_env}" ]; then
    pyenv virtualenv "$python3_ver" "$neovim3_env"
  fi
  pyenv activate "$neovim3_env"
  pip install -U pynvim neovim
  # deactivate
  pyenv deactivate
}

setup_language_servers() {
  # pyls
  local pyls_env="pyls"
  if [ ! -d "$(pyenv root)/versions/${pyls_env}" ]; then
    pyenv virtualenv "$python3_ver" "$pyls_env"
  fi
  pyenv activate "$pyls_env"
  pip install -U python-language-server
  pyenv deactivate
  # go
  go get -u github.com/sourcegraph/go-langserver
}

setup_local_neovim() {
  pushd ~/bin
  rm -f nvim.appimage
  curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
  chmod u+x nvim.appimage
  ln -fs nvim.appimage nvim
  popd
}

readonly targets=${*:-$(guess_target)}

# always make bin dir
mkdir -p ~/bin

for target in $targets; do
  case $target in
    bash-to-zsh)
      if [ -L "$HOME/.bashrc" ]; then
        rm -f "$HOME/.bashrc"
      elif [ -f "$HOME/.bashrc" ]; then
        mv "$HOME/.bashrc" "$HOME/.bashrc.backup.$(date +%F_%R)"
      fi
      stow bash-to-zsh
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
      setup_pyenv
      ;;
    neovim)
      setup_neovim_venv
      setup_local_neovim
      setup_language_servers
      ;;
    *)
      echo "Unknown target $target" 2>&1
      exit 1
      ;;
  esac
done
