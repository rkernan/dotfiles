export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'

export GOPATH="$HOME/projects/go"

if [[ -z "$LANG" ]]; then
	export LANG='en_US.UTF-8'
fi

alias path='echo -e ${PATH//:/\\n}'

typeset -gU cdpath fpath mailpath path

path=("$HOME/bin" "$GOPATH/bin" $path)

fpath+=("$HOME/.share/zsh")

source "$HOME/.base16/shell/base16-monokai.dark.sh"
