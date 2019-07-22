# general options
setopt no_flow_control # disable output flow control
setopt long_list_jobs  # list jobs in the long format by defaut
setopt notify          # report the status of background processes immediately
setopt hash_list_all   # hash entire command path before first completion
setopt extended_glob   # treat #, ~, and ^ as part of patterns for filename completion

setopt prompt_subst

# vcs_info
zstyle ':vcs_info:*' enable bzr cdv cvs darcs fossil git tla hg mtn p4 svn svk
zstyle ':vcs_info:*' stagedstr '%F{green}●%f'
zstyle ':vcs_info:*' unstagedstr '%F{yellow}●%f'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' formats ' %f[%F{cyan}%b%f%c%u%m%f]'
zstyle ':vcs_info:*' actionformats ' %f[%F{cyan}%b!%a%f%c%u%m%f]'

zstyle ':vcs_info:git*+set-message:*' hooks git-untracked

+vi-git-untracked() {
  if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && git status --porcelain | fgrep '??' &> /dev/null; then
    hook_com[misc]='%F{red}●%f'
  fi
}

# python_info
zstyle ':python_info:virtualenv' format 'pyenv:%v '

python_info_virtualenv() {
  unset python_info[virtualenv]
  typeset -gA python_info
  local virtualenv_format
  zstyle -s ':python_info:virtualenv' format 'virtualenv_format'
  if [[ -n $virtualenv_format && -n "$PYENV_VERSION" ]]; then
    zformat -f python_info[virtualenv] "$virtualenv_format" "v:${PYENV_VERSION:t}"
  fi
}

set_term_title() {
  case $TERM in
    xterm*)
      print -Pn "\e];%~\a"
      ;;
  esac
}

# run on prompt refresh
precmd() {
  set_term_title
  vcs_info
  python_info_virtualenv
}

# set prompt
PROMPT='%F{white}$python_info[virtualenv]%f%F{green}%c%f${vcs_info_msg_0_} %F{yellow}%(1j.%j%D{ }.)%(?..%F{red}%? )%f%# '

# pushd settings
setopt pushd_ignore_dups
export DIRSTACKSIZE=10

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

# history
export HISTFILE="${ZDOTDIR:-$HOME}/.zhistory"
export HISTSIZE=100000
export SAVEHIST=100000
setopt extended_history       # write history with timestamps
setopt append_history         # allow multiple sessions to write history
setopt inc_append_history     # write to history immediately
setopt hist_ignore_all_dups   # ignore duplicate entries
setopt hist_reduce_blanks     # remove extra blanks on expansion
setopt hist_verify            # dont execute immediately on completion
setopt share_history          # share history between sessions

# completion
autoload -Uz compinit && compinit -i
setopt complete_in_word # allow completion inside word
setopt auto_menu        # automatically use menu after second completion request
setopt no_nomatch       # disable "No matches..." dialog
# case insensitive when lowercase (smartcase)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# emacs mode
bindkey -e

# edit current command in VISUAL
autoload -U edit-command-line && zle -N edit-command-line
bindkey '^x^e' edit-command-line

# bindings
bindkey -e
bindkey '^r' history-incremental-pattern-search-backward
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey ' ' magic-space
autoload -Uz vcs_info

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

extract() {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)
        tar -vxjf $1
        ;;
      *.tar.gz)
        tar -vxzf $1
        ;;
      *.bz2)
        bunzip2 -v $1
        ;;
      *.rar)
        rar x $1
        ;;
      *.gz)
        gunzip $1
        ;;
      *.tar)
        tar -vxf $1
        ;;
      *.tbz2)
        tar -vxjf $1
        ;;
      *.tgz)
        tar -vxzf $1
        ;;
      *.zip)
        unzip $1
        ;;
      *.Z)
        uncompress $1
        ;;
      *.7z)
        7z x $1
        ;;
      *)
        echo "'$1' cannot be extracted"
        ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

if (( $+commands[srm] )); then
  alias srm='nocorrect srm'
fi

if (( $+commands[xsel] )); then
  alias clip='xsel --clipboard --input'
  alias paste='xsel --clipboard --output'
fi

if (( $+commands[xdg-open] )); then
  alias open='xdg-open'
fi

# pyenv
if (( $+commands[pyenv] )); then
  export PYENV_VIRTUALENV_DISABLE_PROMPT=1
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

# fzf
if [ -f ~/.fzf.zsh ]; then
  if (( $+commands[rg] )); then
    # file list
    _fzf_compgen_path() {
      command rg --hidden --files
    }

    # directory list
    _fzf_compgen_dir() {
      command rg --hidden --files --null | xargs -0 dirname | uniq
    }
  fi

  export FZF_DEFAULT_OPTS="--layout=reverse"
  source ~/.fzf.zsh

  # fuzzy edit
  fe() {
    e $(_fzf_compgen_path | fzf --multi)
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
      pid=$(ps -f -u $UID | sed 1d | fzf --multi | awk '{print $2}')
    else
      pid=$(ps -ef | sed 1d | fzf --multi | awk '{print $2}')
    fi

    if [ ! -z $pid ]; then
      echo $pid | xargs kill $code
    fi
  }
fi
