fish_add_path $HOME"/.local/bin"

# brew
set -l brew_prefix /home/linuxbrew/.linux
if test -d $brew_prefix
  # path
  fish_add_path $brew_prefix"/sbin"
  fish_add_path $brew_prefix"/bin"
  # completions
  set -gx fish_complete_path $fish_complete_path $brew_prefix"/share/fish/completions"
  set -gx fish_complete_path $fish_complete_path $brew_prefix"/share/fish/vendor_completions.d"
end

# asdf
set -l asdf_brew_path $brew_prefix"/opt/asdf"
if test -d $asdf_brew_path
  source $asdf_brew_path"/opt/asdf/libexec/asdf.fish"
end

# go
set -l go_path $HOME"/workspace/go"
if test -d $go_path
  set -x GOPATH $go_path
  fish_add_path $GOPATH"/bin"
end

# env
set -x EDITOR nvim
set -x PAGER less

# install fisher to custom directory
set -U fisher_path $HOME"/.config/fisher"

#=========================#
# interactive mode config #
#=========================#
status is-interactive || exit

_autostart_tmux

# fzf config
set -x FZF_DEFAULT_OPTS "--cycle --layout=reverse --preview-window=default,border-sharp --height=75% --info=inline"
set -x FZF_DEFAULT_COMMAND "_fzf_list_files \$dir"
set -x FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
set -x FZF_CTRL_T_OPTS "--preview='_fzf_file_preview {}'"
set -x FZF_CTRL_R_OPTS "$FZF_DEFAULT_OPTS --prompt='History> '"
set -x FZF_ALT_C_COMMAND "_fzf_list_dirs \$dir"
set -x FZF_ALT_C_OPTS "$FZF_DEFAULT_OPTS --prompt='Dirs> '"

# aliases
abbr e $EDITOR
abbr p $PAGER

abbr cp cp -i
abbr ln ln -i
abbr mv mv -i
abbr rm rm -i
