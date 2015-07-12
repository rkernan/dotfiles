export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'

if [[ -z "$LANG" ]]; then
	export LANG='en_US.UTF-8'
fi

typeset -gU cdpath fpath mailpath path

path=("$HOME/bin" $path)

source "$HOME/.base16/shell/base16-monokai.dark.sh"
