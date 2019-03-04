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
# npm path
export NPM_PACKAGES="${HOME}/.npm"
path=("${NPM_PACKAGES}/bin" $path)
# user path
path=("$HOME/bin" $path)

export VISUAL=$(whence 'nvim' || whence 'vim')
export EDITOR=$VISUAL
export PAGER=$(whence 'less')

export PATH="$HOME/.cargo/bin:$PATH"
