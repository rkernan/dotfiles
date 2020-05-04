# start tmux first if we wwant it
if (( $+commands[tmux] )); then
  case $- in *i*)
    # auto-launch tmux - only in interactive shell
    if [[ -z "$TMUX" && "${ZSH_TMUX_AUTOSTART:-0}" == 1 && "${ZSH_TMUX_AUTOSTARTED:-0}" == 0 && -z "$VIM" ]]; then
      export ZSH_TMUX_AUTOSTARTED=1
      tmux attach || tmux new-session
      # exit when done
      exit
    fi
  esac
fi

# install zinit
if [ ! -e "${HOME}/.zinit" ]; then
  curl -sL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh | bash -s
fi

# zinit
source "${HOME}/.zinit/bin/zinit.zsh"

zinit light mafredri/zsh-async
zinit light starcraftman/zsh-git-prompt
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions

# vim mode
bindkey -v
bindkey '^ ' autosuggest-accept
bindkey ' '  magic-space
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_MANUAL_REBIND=true
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_USE_ASYNC=true

# pushd settings
setopt pushd_ignore_dups
DIRSTACKSIZE=10

# don't expand ~
pwd_no_expand() {
  echo "${PWD/$HOME/~}"
}

# hide pushd stdout
pushd() {
  builtin pushd "$@" > /dev/null
}

# hide popd stdout, print directory after
popd() {
  builtin popd "$@" > /dev/null
  pwd_no_expand
}

# print directory after cd
cd() {
  builtin cd "$@" > /dev/null
  pwd_no_expand
}

# are we connected through ssh?
is_ssh() {
  [[ -n "${SSH_CONNECTION-}${SSH_CLIENT-}${SSH_TTY}" ]]
}

autoload -Uz colors
colors

prompt_precmd() {
  # set window title
  local window_title="\033k${${PWD/$HOME/~}##*/}\033\\"
  printf "$window_title"
  # display username@hostname if we're remote
  is_ssh && psvar[1]='%F{cyan}%n@%m%f ' || psvar[1]=''
  # async git prompt
  psvar[2]=''
  async_start_worker async_prompt_worker -n
  async_register_callback async_prompt_worker async_prompt_callback
  async_job async_prompt_worker git_super_status
  # set default prompt mode
  psvar[3]=$ZSH_PROMPT_MODE
}

async_prompt_callback() {
  psvar[2]=$3
  zle && zle reset-prompt
  async_stop_worker async_prompt_worker -n
}

ZSH_THEME_GIT_PROMPT_PREFIX="("
ZSH_THEME_GIT_PROMPT_SUFFIX=") "
ZSH_THEME_GIT_PROMPT_SEPARATOR="|"
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg_bold[magenta]%}"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg[green]%}%{●%G%}"
ZSH_THEME_GIT_PROMPT_CONFLICTS="%{$fg[red]%}%{✖%G%}"
ZSH_THEME_GIT_PROMPT_CHANGED="%{$fg[yellow]%}%{✚%G%}"
ZSH_THEME_GIT_PROMPT_BEHIND="%{↓%G%}"
ZSH_THEME_GIT_PROMPT_AHEAD="%{↑%G%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[red]…%G%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}%{✔%G%}"

ZSH_PROMPT_MODE="${ZSH_PROMPT_MODE:-❯}"
ZSH_PROMPT_VICMD_MODE="${ZSH_PROMPT_VICMD_MODE:-❮}"

function zle-keymap-select() {
  # old fasioned way because this doesn't work on some systems, need zsh 5.3+
  psvar[3]=${${KEYMAP/vicmd/${ZSH_PROMPT_VICMD_MODE}}/(main|viins)/${ZSH_PROMPT_MODE}}
  zle && zle reset-prompt
}
zle -N zle-keymap-select

autoload -Uz add-zsh-hook
add-zsh-hook precmd prompt_precmd

setopt PROMPT_SUBST

PROMPT="%(1j.%F{yellow}%j%D{ }%f.)%(?..%F{red}%?%f )\$psvar[1]%F{green}%c%f \$psvar[2]%f\$psvar[3]%f "
RPROMPT=""

# history
HISTFILE="${ZDOTDIR:-$HOME}/.zhistory"
HISTSIZE=1000
SAVEHIST=1000
setopt extended_history       # write history with timestamps
setopt append_history         # allow multiple sessions to write history
setopt inc_append_history     # write to history immediately
setopt hist_ignore_all_dups   # ignore duplicate entries
setopt hist_reduce_blanks     # remove extra blanks on expansion
setopt hist_verify            # dont execute immediately on completion
setopt share_history          # share history between sessions

# completion
autoload -Uz compinit
compinit
setopt complete_in_word # allow completion inside word
setopt auto_menu        # automatically use menu after second completion request
setopt no_nomatch       # disable "No matches..." dialog
# case insensitive when lowercase (smartcase)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# nocorrect
alias ack='nocorrect ack'
alias cd='nocorrect cd'
alias cp='nocorrect cp -i'
alias grep='nocorrect grep --color=auto'
alias ln='nocorrect ln -i'
alias man='nocorrect man'
alias mkdir='nocorrect mkdir -p'
alias mv='nocorrect mv -i'
alias rm='nocorrect rm -i'
# noglob
alias find='noglob find'
alias ftp='noglob ftp'
alias history='noglob history'
alias locate='noglob locate'
alias rsync='noglob rsync'
alias scp='noglob scp'
alias sftp='noglob sftp'
# shortcuts
alias dirs='dirs -v'
alias df='df -kh'
alias e='$EDITOR'
alias history-stat="history 0 | awk '{print \$2}' | sort | uniq -c | sort -n -r | head"
alias la='ls --group-directories-first --color=auto -lhA'
alias ll='ls --group-directories-first --color=auto -lh'
alias ls='ls --group-directories-first --color=auto'
alias p='$PAGER'
alias path='echo -e ${PATH//:/\\n}'

if (( $+commands[srm] )); then
  alias srm='nocorrect srm'
fi

if (( $+commands[xdg-open] )); then
  alias open='xdg-open'
fi

if (( $+commands[pyenv] )); then
  export PYENV_VIRTUALENV_DISABLE_PROMPT=1
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

if [ -e "${HOME}/.fzf.zsh" ]; then

  source "${HOME}/.fzf.zsh"

  # file list
  _fzf_compgen_path() {
    command rg --hidden --files $1
  }

  # directory list
  _fzf_compgen_dir() {
    command rg --hidden --files --null $1 | xargs -0 dirname | uniq
  }

  export FZF_DEFAULT_COMMAND="rg --hidden --files"
  export FZF_DEFAULT_OPTS="--layout=reverse"

  # fuzzy edit
  fe() {
    e $(_fzf_compgen_path | fzf -m)
  }

  # fuzzy cd
  fcd() {
    cd $(_fzf_compgen_dir | fzf)
  }

  # fuzzy kill processes
  fkill() {
    local code=${1}
    local pid
    if [ "$UID" != "0" ]; then
      pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
    else
      pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
    fi

    if [ ! -z $pid ]; then
      echo $pid | xargs kill $code
    fi
  }
fi
