fish_add_path $HOME"/.local/bin"

# brew
set -l brew_prefix /home/linuxbrew/.linuxbrew
if test -d $brew_prefix
  # path
  fish_add_path $brew_prefix"/sbin"
  fish_add_path $brew_prefix"/bin"
  # completions
  set -gx fish_complete_path $fish_complete_path $brew_prefix"/share/fish/completions"
  set -gx fish_complete_path $fish_complete_path $brew_prefix"/share/fish/vendor_completions.d"
end

# go
if type -q go
  fish_add_path (go env GOPATH)"/bin"
end

# rust
set -l cargo_path $HOME"/.cargo/env.fish"
if test -e $cargo_path
  source $cargo_path
end

# env
set -x EDITOR nvim
set -x PAGER less

#=========================#
# interactive mode config #
#=========================#
status is-interactive || exit

_autostart_tmux

if not functions -q fundle
  eval (curl -sfL https://git.io/fundle-install)
end
fundle plugin 'jorgebucaran/autopair.fish'
fundle plugin 'andreiborisov/sponge'
fundle init

# fzf config
set -x FZF_DEFAULT_OPTS "--cycle --layout=reverse --border=none --preview-window=border-sharp,right:60% --height=60% --info=inline"
set -x FZF_DEFAULT_COMMAND "_fzf_list_files \$dir"
set -x FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
set -x FZF_CTRL_T_OPTS "--preview='_fzf_file_preview {}'"
set -x FZF_CTRL_R_OPTS "$FZF_DEFAULT_OPTS --prompt='History> '"
set -x FZF_ALT_C_COMMAND "_fzf_list_dirs \$dir"
set -x FZF_ALT_C_OPTS "$FZF_DEFAULT_OPTS --prompt='Dirs> '"

# ripgrep config
set -x RIPGREP_CONFIG_PATH $HOME"/.ripgreprc"

# aliases
abbr e $EDITOR
abbr p $PAGER

function subcommand_abbr -a cmd short long
  set -l abbr_fn_name (string join "_" "abbr" "$cmd" "$short")
  set -l abbr_fn "
function $abbr_fn_name
  set --local tokens (commandline --tokenize)
  if test \$tokens[1] = \"$cmd\"
    echo $long
  else
    echo $short
  end
end
abbr --add $short --position anywhere --function $abbr_fn_name
  "
  eval "$abbr_fn"
end

abbr g git
subcommand_abbr git a add
subcommand_abbr git aa "add --all"
subcommand_abbr git ap "add --patch"
subcommand_abbr git unstage "restore --staged"
subcommand_abbr git co checkout
subcommand_abbr git cob "checkout -b"
subcommand_abbr git ci commit
subcommand_abbr git amend "commit --amend"

abbr cp cp -i
abbr ln ln -i
abbr mv mv -i
abbr rm rm -i
