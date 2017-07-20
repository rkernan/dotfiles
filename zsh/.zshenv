export EDITOR='vim'
if which nvim > /dev/null 2>&1; then
	export EDITOR='nvim'
fi
export VISUAL=$EDITOR
export PAGER='less'

if [[ -z "$LANG" ]]; then
	export LANG='en_US.UTF-8'
fi

typeset -gU cdpath fpath mailpath path

path=("$HOME/bin" $path)

autoload -Uz vcs_info

setopt prompt_subst

# vcs_info
zstyle ':vcs_info:*' enable bzr cdv cvs darcs fossil git tla hg mtn p4 svn svk
zstyle ':vcs_info:*' stagedstr '%F{green}M%f'
zstyle ':vcs_info:*' unstagedstr '%F{yellow}M%f'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' formats '[%F{cyan}%b%f%c%u%m]'
zstyle ':vcs_info:*' action formats '[%F{cyan}%b!%a%f]'

zstyle ':vcs_info:git*+set-message:*' hooks git-untracked

+vi-git-untracked() {
	if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && git status --porcelain | fgrep '??' &> /dev/null; then
		hook_com[misc]='%F{red}?%f'
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
