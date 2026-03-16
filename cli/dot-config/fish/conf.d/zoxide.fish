zoxide init fish | source
set -x _ZO_EXCLUDE_DIRS (string join ':' $HOME $HOME"/.*")
set -x _ZO_FZF_OPTS $FZF_DEFAULT_OPTS "--height=10 --prompt='zoxide> ' --no-multi"
