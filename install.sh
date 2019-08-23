#!/usr/bin/env bash

set -e

readonly python3_ver="3.7.2"

function stow {
  command stow -t "$HOME" -v "$1"
}

version() {
  echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }'
}

guess_target() {
  if [ $(command -v pacman) ]; then
    # arch linux
    echo bin-arch cli gui
  elif [ $(command -v yum) ]; then
    # centos/rhel/fedora - work
    echo bash-to-zsh cli
  else
    # other
    echo cli
  fi
}

install_fzf() {
  local fzf_root="$HOME/.fzf"
  if [ ! -d "$fzf_root" ]; then
    git clone https://github.com/junegunn/fzf.git "$fzf_root"
  fi
  ${fzf_root}/install --all --no-bash
}

install_ripgrep() {
  cargo install-update ripgrep
}

install_nvim() {
  # setup neovim3 virtualenv
  readonly neovim3_env="neovim3"
  if [ ! -d "$(pyenv root)/versions/${neovim3_env}" ]; then
    pyenv virtualenv "$python3_ver" "$neovim3_env"
  fi
  pyenv activate "$neovim3_env"
  python -m pip install -U pynvim neovim
  # deactivate
  pyenv deactivate
  # install nvim
  pushd ~/bin
  rm -f nvim.appimage
  curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
  chmod u+x nvim.appimage
  ln -fsr nvim.appimage nvim
  popd
}

install_cargo() {
  if [ ! -e "$HOME/.rustup" ]; then
    curl -sL https://sh.rustup.rs | bash -s -- --no-modify-path -y
  fi
  rustup update
  # install (or update) cargo-update
  local pkg="cargo-update"
  cargo install-update "$pkg" || cargo install "$pkg"
}

install_nodejs() {
  local req_ver="12.0.0"
  local actual_ver=$(node --version)
  local actual_ver=${actual_ver:1}
  # only update if we need to (or already have)
  if [ ! $(command -v node) ] || [ -e "${HOME}/.local/bin/node" ] || [ $(version $actual_ver) -lt $(version $req_version) ]; then
    curl -sL https://install-node.now.sh | bash -s -- --prefix="${HOME}/.local" -y
  fi
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

install_go_lsp() {
  go get -u golang.org/x/tools/gopls
}

install_python_lsp() {
  pip install --user -U jedi pylint rope
}

install_rust_lsp() {
  rustup component add rls rust-analysis rust-src
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
      stow bin
      stow git
      stow nvim
      stow tmux
      stow zsh
      # source environment, may have changed
      source "${HOME}/.profile"
      # package managers
      install_cargo
      install_nodejs
      install_pyenv
      # utilities
      install_fzf
      install_nvim
      install_ripgrep
      # language servers
      install_go_lsp
      install_python_lsp
      install_rust_lsp
      # neovim
      update_nvim_plugins
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
