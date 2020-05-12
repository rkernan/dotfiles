export EDITOR="nvim"
export VISUAL="$EDITOR"
export PAGER="less"

if [ -e "${HOME}/.at_work" ]; then
  export ZSH_PROMPT_MODE=">"
  export ZSH_PROMPT_VICMD_MODE="<"
fi

export GOPATH="${HOME}/Workspace/go"

typeset -Ug path

path+=("${HOME}/.local/bin")
path+=("/home/linuxbrew/.linuxbrew/bin")
path+=("${HOME}/.linuxbrew/bin")
path+=("${HOME}/.cargo/bin")
path+=("${GOPATH}/bin")

export ZSH_TMUX_AUTOSTART=1
