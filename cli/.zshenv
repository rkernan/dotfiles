emulate sh -c "source ${HOME}/.profile"

typeset -Ug path

if [[ $NO_UNICODE -gt 0 ]]; then
  export ZSH_PROMPT_MODE=">"
  export ZSH_PROMPT_VICMD_MODE="<"
fi

export ZSH_TMUX_AUTOSTART=${ZSH_TMUX_AUTOSTART:-1}
