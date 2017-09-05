setopt prompt_subst

# vcs_info
zstyle ':vcs_info:*' enable bzr cdv cvs darcs fossil git tla hg mtn p4 svn svk
zstyle ':vcs_info:*' stagedstr '%F{green}●%f'
zstyle ':vcs_info:*' unstagedstr '%F{yellow}●%f'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' formats '[%F{cyan}%b%f%c%u%m]'
zstyle ':vcs_info:*' action formats '[%F{cyan}%b!%a%f]'

zstyle ':vcs_info:git*+set-message:*' hooks git-untracked

+vi-git-untracked() {
	if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && git status --porcelain | fgrep '??' &> /dev/null; then
		hook_com[misc]='%F{red}●%f'
	fi
}

precmd() {
	vcs_info
}

# set prompt
PROMPT='%F{green}%c %f${vcs_info_msg_0_} %(?..%F{red}%? )%f%b%# '
PROMPT='%(?..%F{red}%? )%F{green}%c %f${vcs_info_msg_0_} %# '

cd() {
	builtin cd "$@"
	builtin pwd
}

# history
HISTFILE="${ZDOTDIR:-$HOME}/.zhistory"
HISTSIZE=10000
SAVEHIST=10000
setopt append_history         # allow multiple sessions to write history
setopt extended_history       # write history with timestamps
setopt hist_expire_dups_first # expire duplicates first when trimming history
setopt hist_ignore_dups       # ignore duplicate entries
setopt hist_reduce_blanks     # remove extra blanks on expansion
setopt hist_verify            # don't execute immediately on completion
setopt inc_append_history     # write to history immediately
setopt share_history          # share history between sessions

# completion
autoload -Uz compinit && compinit -i
setopt complete_in_word
setopt auto_menu
# case insensitive when lowercase (smartcase)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# emacs mode
bindkey -e

# exit current command in EDITOR
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
alias ls='ls --group-directories-first --color=auto'
alias l='ls -1A'
alias ll='ls -lh'
alias la='ll -A'
alias p='$PAGER'
alias path='echo -e ${PATH//:/\\n}'

if (( $+commands[xsel] )); then
	alias pbcopy='xsel --clipboard --input'
	alias pbpaste='xsel --clipboard --output'
fi
