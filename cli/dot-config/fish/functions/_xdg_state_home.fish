function _xdg_state_home --description "XDG_STATE_HOME or default"
  if test -n "$XDG_STATE_HOME"
    printf $XDG_STATE_HOME
  else
    printf $HOME"/.local/state"
  end
end
