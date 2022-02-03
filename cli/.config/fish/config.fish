set -x GOPATH ~/Workspace/go

fish_add_path $GOPATH/bin
fish_add_path $HOME/.cargo/bin
fish_add_path /home/linuxbrew/.linuxbrew/sbin
fish_add_path /home/linuxbrew/.linuxbrew/bin
fish_add_path $HOME/.local/bin

_autostart_tmux

set -x EDITOR nvim
set -x PAGER less

# export environment - we're not the only one that needs this
set -q NO_UNICODE || set -x NO_UNICODE 0

# setup unicode characters for fzf display
if test $NO_UNICODE -gt 0
  set fzf_prompt  '> '
  set fzf_pointer '>'
  set fzf_marker  '>'
else
  set fzf_prompt  '❯ '
  set fzf_pointer '❯'
  set fzf_marker  '❯'
end
set -x FZF_DEFAULT_OPTS "--cycle --layout=reverse --border --height=90% --prompt='$fzf_prompt' --pointer='$fzf_pointer' --marker='$fzf_marker'"

# use fd if it's installed
if type -q fd
  set -x FZF_DEFAULT_COMMAND "fd --type f --hidden --follow --strip-cwd-prefix \$dir"
else
  set -x FZF_DEFAULT_COMMAND "find -L \$dir -type f"
end

set -x FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
set -x FZF_CTRL_T_OPTS "--preview='_fzf_file_preview {}'"

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
