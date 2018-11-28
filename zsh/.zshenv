if [[ -z "$LANG" ]]; then
	export LANG='en_US.UTF-8'
fi

typeset -gU cdpath fpath mailpath path

# pyenv path
path=("$HOME/.pyenv/bin" $path)
# pip install path
path=("$HOME/.local/bin" $path)
# rust path
path=("$HOME/.cargo/bin" $path)
# go path
export GOPATH="${HOME}/workspace/go"
path=("${GOPATH}/bin" $path)
# user path
path=("$HOME/bin" $path)

export VISUAL=$(which 'nvim' || which 'vim')
export EDITOR=$VISUAL
export PAGER=$(which 'less')
