export VISUAL=$(which 'nvim' || which 'vim')
export EDITOR=$VISUAL
export PAGER=$(which 'less')

if [[ -z "$LANG" ]]; then
	export LANG='en_US.UTF-8'
fi

typeset -gU cdpath fpath mailpath path

# pip bin path
path=("$HOME/.local/bin" $path)
# rust bin path
path=("$HOME/.cargo/bin" $path)
# user bin path
path=("$HOME/bin" $path)

# go path
export GOPATH="${HOME}/workspace/go"
path=("${GOPATH}/bin" $path)
