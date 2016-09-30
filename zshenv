if (( $+commands[nvim] )) ; then
	export EDITOR='nvim'
else if (( $+commands[vim] )) ; then
	export EDITOR='vim'
else
	export EDITOR='vi'
fi
export VISUAL=$EDITOR
export PAGER='less'

if [[ -z "$LANG" ]]; then
	export LANG='en_US.UTF-8'
fi

typeset -gU cdpath fpath mailpath path

path=("$HOME/bin" $path)

source "$HOME/.base16/shell/scripts/base16-monokai.sh"
