function ssh
  if test -n $TMUX
    set -f last_window_name (tmux display-message -p '#W')
    tmux set-window-option automatic-rename "off"
    tmux rename-window "ssh:$argv"
  end

  begin
    # set a conservative TERM
    set -lx TERM xterm
    command ssh $argv
  end

  if test -n $last_window_name
    tmux rename-window "$last_window_name"
  end
  tmux set-window-option automatic-rename "on"
end
