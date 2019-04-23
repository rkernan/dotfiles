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
    echo bin-arch cli gui python rust javascript neovim
  elif which yum >/dev/null 2>&1; then
    # centos/rhel/fedora - work
    echo bash-to-zsh cli python javascript neovim
  else
    # other
    echo cli python rust javascript neovim
  fi
}

install_fzf() {
  local fzf_root="$HOME/.fzf"
  if [ ! -d "$fzf_root" ]; then
    git clone https://github.com/junegunn/fzf.git "$fzf_root"
  fi
  ${fzf_root}/install --all --no-bash
}

install_go_langserver() {
  go get -u github.com/saibing/bingo
}

install_javascript_langserver() {
  npm install -g javascript-typescript-langserver
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
}

install_python_langserver() {
  local pyls_env="pyls"
  if [ ! -d "$(pyenv root)/versions/${pyls_env}" ]; then
    pyenv virtualenv "$python3_ver" "$pyls_env"
  fi
  pyenv activate "$pyls_env"
  python -m pip install -U python-language-server
  pyenv deactivate
}

install_rust() {
  if [ ! -d ~/.rustup ]; then
    curl https://sh.rustup.rs -sSf | sh
  fi
  rustup update
}

install_rust_langserver() {
  rustup component add rls rust-analysis rust-src
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
  python -m pip install -U pynvim neovim
  # setup neovim3 virtualenv
  if [ ! -d "$(pyenv root)/versions/${python3_ver}" ]; then
    pyenv install "$python3_ver"
  fi
  local neovim3_env="neovim3"
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
      ;;
    go)
      install_go_langserver
      ;;
    gui)
      stow awesome
      stow rofi
      stow termite
      stow gnupg
      setup_gpg_agent
      ;;
    javascript)
      stow npm
      install_javascript_langserver
      ;;
    neovim)
      setup_neovim_venv
      install_local_neovim
      ;;
    python)
      install_pyenv
      install_python_langserver
      ;;
    rust)
      install_rust
      install_rust_langserver
      ;;
    *)
      echo "Unknown target $target" 2>&1
      exit 1
      ;;
  esac
done
