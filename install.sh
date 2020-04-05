#!/usr/bin/env bash

set -e

readonly python3_ver="3.7.2"

stow() {
  command stow -t "$HOME" -v "$1"
}

version() {
  echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }'
}

command_exists() {
  local cmd=$1
  if [ -x "$(command -v $cmd)" ]; then
    return 0
  else
    return 1
  fi
}

guess_target() {
  if [ $(command -v pacman) ]; then
    # arch linux
    echo cli gui
  elif [ $(command -v yum) ]; then
    # centos/rhel/fedora - work
    echo cli work
  else
    # other
    echo cli
  fi
}

install_brew() {
  if ! command_exists brew; then
    curl -sL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | bash -s
  else
    brew update
  fi
}

install_rust() {
  if [ ! -e "$HOME/.rustup" ]; then
    curl -sL https://sh.rustup.rs | bash -s -- --no-modify-path -y
  fi
  rustup update
  rustup component add rls rust-analysis rust-src
}

install_neovim() {
  if ! command_exists nvim; then
    brew install neovim
    python3 -m pip install --user -U pynvim
  fi
}

update_nvim_plugins() {
  # install plugins
  nvim +PlugUpdate +qall
  # force update Coc extensions
  nvim +CocUpdate +qall
}

setup_gpg_agent() {
  pushd "${HOME}/.config/systemd/user"
  cp -f /usr/share/doc/gnupg/examples/systemd-user/* .
  systemctl --user daemon-reload
  systemctl --user enable *.socket
  popd
}

readonly targets=${*:-$(guess_target)}

# don't clobber these directories
mkdir -p ~/bin
mkdir -p ~/.config

for target in $targets; do
  case $target in
    cli)
      stow cli
      # install homebrew
      install_brew
      # source environment, may have changed
      source "${HOME}/.profile"
      # install programs
      command_exists ctags || brew install ctags
      command_exists npm   || brew install npm
      command_exists go    || brew install go
      install_rust
      command_exists rg || cargo install ripgrep
      go get -u golang.org/x/tools/gopls
      python3 -m pip install --user -U jedi pylint rope
      install_neovim
      # update neovim stuff
      update_nvim_plugins
      ;;
    gui)
      stow gui
      setup_gpg_agent
      ;;
    work)
      stow work
      ;;
    *)
      echo "Unknown target $target" 2>&1
      exit 1
      ;;
  esac
done
