set -x FZF_DEFAULT_OPTS "--cycle --layout=reverse --style=minimal --info=inline --height=20"
set -x FZF_DEFAULT_COMMAND "_list_files \$dir"
set -x FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
set -x FZF_CTRL_T_OPTS "--prompt='files> '"
set -x FZF_CTRL_R_OPTS "--prompt='history> ' --no-multi"
set -x FZF_ALT_C_COMMAND "_list_dirs \$dir"
set -x FZF_ALT_C_OPTS "--prompt='dirs> '"
