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
