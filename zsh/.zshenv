export VISUAL=$(which 'nvim' || which 'vim')
export EDITOR=$VISUAL
export PAGER=$(which 'less')

if [[ -z "$LANG" ]]; then
	export LANG='en_US.UTF-8'
fi

typeset -gU cdpath fpath mailpath path

# add local bin to path - pip installs here
path=("$HOME/.local/bin" $path)
# add ~/bin to path
path=("$HOME/bin" $path)

# go path
export GOPATH="${HOME}/workspace/go"
path=("${GOPATH}/bin" $path)
