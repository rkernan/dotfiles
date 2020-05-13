export EDITOR="nvim"
export VISUAL="$EDITOR"
export PAGER="less"
export GOPATH="${HOME}/Workspace/go"

export PATH="${GOPATH}/bin:$PATH"
export PATH="${HOME}/.cargo/bin:$PATH"
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
export PATH="${HOME}/.linuxbrew/bin:$PATH"
export PATH="${HOME}/.local/bin:$PATH"

if [ -f "${HOME}/.profile.override" ]; then
  source "${HOME}/.profile.override"
fi
