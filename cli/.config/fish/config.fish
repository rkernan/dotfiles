set -x GOPATH ~/Workspace/go

fish_add_path $GOPATH/bin
fish_add_path $HOME/.cargo/bin
fish_add_path /home/linuxbrew/.linuxbrew/sbin
fish_add_path /home/linuxbrew/.linuxbrew/bin
fish_add_path $HOME/.local/bin

_autostart_tmux

set -q NO_UNICODE || set -x NO_UNICODE 0

set -g __fish_git_prompt_show_informative_status 1
set -g __fish_git_prompt_color_branch magenta --bold
set -g __fish_git_prompt_showupstream "informative"
set -g __fish_git_prompt_char_upstream_prefix ""
set -g __fish_git_prompt_color_cleanstate green --bold
set -g __fish_git_prompt_color_stagedstate green
set -g __fish_git_prompt_color_dirtystate yellow
set -g __fish_git_prompt_color_invalidstate red
set -g __fish_git_prompt_color_untrackedfiles red

if set -q NO_UNICODE; and test $NO_UNICODE -gt 0
  set -g __fish_git_prompt_char_upstream_ahead "↑"
  set -g __fish_git_prompt_char_upstream_behind "↓"
  set -g __fish_git_prompt_char_cleanstate "!"
  set -g __fish_git_prompt_char_stagedstate "+"
  set -g __fish_git_prompt_char_dirtystate "+"
  set -g __fish_git_prompt_char_invalidstate "x"
  set -g __fish_git_prompt_char_untrackedfiles "??"

  set -g __fish_vi_prompt_default_suffix "<"
  set -g __fish_vi_prompt_insert_suffix ">"
  set -g __fish_vi_prompt_replace_one_suffix "<"
  set -g __fish_vi_prompt_replace_suffix "<"
  set -g __fish_vi_prompt_visual_suffix "<"
else
  set -g __fish_git_prompt_char_upstream_ahead "↑"
  set -g __fish_git_prompt_char_upstream_behind "↓"
  set -g __fish_git_prompt_char_cleanstate "✓"
  set -g __fish_git_prompt_char_stagedstate "·"
  set -g __fish_git_prompt_char_dirtystate "+"
  set -g __fish_git_prompt_char_invalidstate "⨯"
  set -g __fish_git_prompt_char_untrackedfiles "…"

  set -g __fish_vi_prompt_default_suffix "❮"
  set -g __fish_vi_prompt_insert_suffix "❯"
  set -g __fish_vi_prompt_replace_one_suffix "❮"
  set -g __fish_vi_prompt_replace_suffix "❮"
  set -g __fish_vi_prompt_visual_suffix "❮"
end

set -x FZF_DEFAULT_OPTS "--cycle --layout=reverse --border --height=75% --info=inline"

set -x FZF_DEFAULT_COMMAND "_fzf_list_files \$dir"
set -x FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
set -x FZF_CTRL_T_OPTS "--preview='_fzf_file_preview {}'"
set -x FZF_CTRL_R_OPTS "--prompt='History> '"
set -x FZF_ALT_C_COMMAND "_fzf_list_dirs \$dir"
set -x FZF_ALT_C_OPTS "$FZF_DEFAULT_COMMAND --prompt='Dirs> '"

set -x EDITOR nvim
set -x PAGER less

abbr e $EDITOR
abbr p $PAGER

abbr cp cp -i
abbr ln ln -i
abbr mv mv -i
abbr rm rm -i

set fish_color_command normal
set fish_color_redirection brblack --bold
set fish_color_end brblack --bold
set fish_color_param normal

# sane umask
umask 0022
