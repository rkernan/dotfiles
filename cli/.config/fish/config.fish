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

_autostart_tmux

set -q NO_UNICODE || set -x NO_UNICODE 0

# command colors
set fish_color_command normal
set fish_color_redirection brblack --bold
set fish_color_end brblack --bold
set fish_color_param normal

# prompt colors and symbols
set -g __fish_git_prompt_show_informative_status 1
set -g __fish_git_prompt_color_branch magenta --bold
set -g __fish_git_prompt_showupstream "informative"
set -g __fish_git_prompt_char_upstream_prefix ""
set -g __fish_git_prompt_color_cleanstate green --bold
set -g __fish_git_prompt_color_stagedstate green
set -g __fish_git_prompt_color_dirtystate yellow
set -g __fish_git_prompt_color_invalidstate red
set -g __fish_git_prompt_color_untrackedfiles red

set -g __fish_vi_prompt_default_suffix "<"
set -g __fish_vi_prompt_insert_suffix ">"
set -g __fish_vi_prompt_replace_one_suffix "<"
set -g __fish_vi_prompt_replace_suffix "<"
set -g __fish_vi_prompt_visual_suffix "<"

if test $NO_UNICODE -gt 0
  set -g __fish_git_prompt_char_upstream_ahead "↑"
  set -g __fish_git_prompt_char_upstream_behind "↓"
  set -g __fish_git_prompt_char_cleanstate "!"
  set -g __fish_git_prompt_char_stagedstate "+"
  set -g __fish_git_prompt_char_dirtystate "+"
  set -g __fish_git_prompt_char_invalidstate "x"
  set -g __fish_git_prompt_char_untrackedfiles "??"
else
  set -g __fish_git_prompt_char_upstream_ahead "↑"
  set -g __fish_git_prompt_char_upstream_behind "↓"
  set -g __fish_git_prompt_char_cleanstate "✓"
  set -g __fish_git_prompt_char_stagedstate "·"
  set -g __fish_git_prompt_char_dirtystate "+"
  set -g __fish_git_prompt_char_invalidstate "⨯"
  set -g __fish_git_prompt_char_untrackedfiles "…"
end

# fzf config
set -x FZF_DEFAULT_OPTS "--cycle --layout=reverse --preview-window=default,border-sharp --height=75% --info=inline"
set -x FZF_DEFAULT_COMMAND "_fzf_list_files \$dir"
set -x FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
set -x FZF_CTRL_T_OPTS "--preview='_fzf_file_preview {}'"
set -x FZF_CTRL_R_OPTS "$FZF_DEFAULT_OPTS --prompt='History> '"
set -x FZF_ALT_C_COMMAND "_fzf_list_dirs \$dir"
set -x FZF_ALT_C_OPTS "$FZF_DEFAULT_OPTS --prompt='Dirs> '"

# env
set -x EDITOR nvim
set -x PAGER less

# aliases
abbr e $EDITOR
abbr p $PAGER

abbr cp cp -i
abbr ln ln -i
abbr mv mv -i
abbr rm rm -i

# sane umask
umask 0022
