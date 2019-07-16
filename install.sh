#!/usr/bin/env bash

set -e

readonly python3_ver="3.7.2"
readonly neovim3_env="neovim3"

function stow {
  command stow -t "$HOME" -v "$1"
}

guess_target() {
  if which pacman >/dev/null 2>&1; then
    # arch linux
    echo bin-arch cli gui
  elif which yum >/dev/null 2>&1; then
    # centos/rhel/fedora - work
    echo bash-to-zsh cli
  else
    # other
    echo cli
  fi
}

install_cargo() {
  if [ ! -e "$HOME/.rustup" ]; then
    curl https://sh.rustup.rs -sSf | sh
  fi
  rustup update
}

install_ripgrep() {
  # fails if already installed... just pass
  cargo install ripgrep || true
}

install_fzf() {
  local fzf_root="$HOME/.fzf"
  if [ ! -d "$fzf_root" ]; then
    git clone https://github.com/junegunn/fzf.git "$fzf_root"
  fi
  ${fzf_root}/install --all --no-bash
}

install_pyenv() {
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
  # install versions - we use later
  pyenv install -s "$python3_ver"
}

setup_neovim_venv() {
  # setup neovim3 virtualenv
  if [ ! -d "$(pyenv root)/versions/${neovim3_env}" ]; then
    pyenv virtualenv "$python3_ver" "$neovim3_env"
  fi
  pyenv activate "$neovim3_env"
  python -m pip install -U pynvim neovim
  # deactivate
  pyenv deactivate
}

install_local_neovim() {
  pushd ~/bin
  rm -f nvim.appimage
  curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
  chmod u+x nvim.appimage
  ln -fs nvim.appimage nvim
  popd
}

setup_neovim() {
  # install plugins
  nvim +PlugUpdate +qall
  # install python linters
  pyenv activate "$neovim3_env"
  pip install -U jedi
  pyenv deactivate
  # install linters globally
  pip install --user -U flake8 mypy pylint
}

setup_gpg_agent() {
  pushd "${HOME}/.config/systemd/user"
  cp -f /usr/share/doc/gnupg/examples/systemd-user/* .
  systemctl --user daemon-reload
  systemctl --user enable *.socket
  popd
}

readonly targets=${*:-$(guess_target)}

# always make bin dir
mkdir -p ~/bin

for target in $targets; do
  case $target in
    bash-to-zsh)
      if [ -f "${HOME}/.bashrc" ] && [ ! -L "${HOME}/.bashrc" ]; then
        mv "${HOME}/.bashrc" "${HOME}/.bashrc.backup.$(date +%F_%R)"
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
      install_fzf
      install_pyenv
      install_cargo
      install_ripgrep
      setup_neovim_venv
      install_local_neovim
      setup_neovim
      ;;
    gui)
      stow awesome
      stow rofi
      stow kitty
      setup_gpg_agent
      ;;
    *)
      echo "Unknown target $target" 2>&1
      exit 1
      ;;
  esac
done
