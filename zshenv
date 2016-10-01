export EDITOR='nvim'
export VISUAL=$EDITOR
export PAGER='less'

if [[ -z "$LANG" ]]; then
	export LANG='en_US.UTF-8'
fi

typeset -gU cdpath fpath mailpath path

path=("$HOME/bin" $path)

# source $HOME/.config/base16/shell/scripts/base16-monokai.sh
BASE16_SHELL=$HOME/.config/base16/shell
if [ -s $BASE16_SHELL/profile_helper.sh ]; then
	eval "$($BASE16_SHELL/profile_helper.sh)"
fi
