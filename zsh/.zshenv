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

# add ~/bin to path
path=("$HOME/bin" $path)

# go path
export GOPATH="${HOME}/workspace/go"
path=($path "${GOPATH}/bin")
