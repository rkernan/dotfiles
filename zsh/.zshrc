# zplugin
source "${HOME}/.zplugin/bin/zplugin.zsh"

# general options
setopt no_flow_control # disable output flow control
setopt long_list_jobs  # list jobs in the long format by defaut
setopt notify          # report the status of background processes immediately
setopt hash_list_all   # hash entire command path before first completion
setopt extended_glob   # treat #, ~, and ^ as part of patterns for filename completion

autoload -U promptinit
promptinit

# ZSH_THEME_GIT_PROMPT_PREFIX=" %F{cyan}"
# ZSH_THEME_GIT_PROMPT_SUFFIX="%b%f"
# ZSH_THEME_GIT_PROMPT_AHEAD="↑"
# ZSH_THEME_GIT_PROMPT_BEHIND="↓"
# ZSH_THEME_GIT_PROMPT_UNTRACKED="%F{red}●%f"
# PROMPT='%F{green}%c%f${vcs_info_msg_0_} %F{yellow}%(1j.%j%D{ }.)%(?..%F{red}%? )%f%# '

# TODO git prompt
PROMPT='%F{green}%c %F{yellow}%(1j.%j%D{ }.)%(?..%F{red}%? )%f%# '
RPROMPT=""

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
autoload -Uz compinit
compinit
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

if (( $+commands[pyenv] )); then
  export PYENV_VIRTUALENV_DISABLE_PROMPT=1
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

if [ -f ~/.fzf.zsh ]; then
  if (( $+commands[rg] )); then
    # file list
    _fzf_compgen_path() {
      command rg --hidden --files $1
    }

    # directory list
    _fzf_compgen_dir() {
      command rg --hidden --files --null $1 | xargs -0 dirname | uniq
    }
  fi

  export FZF_DEFAULT_COMMAND="rg --hidden --files"
  export FZF_DEFAULT_OPTS="--layout=reverse"

  source ~/.fzf.zsh

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
