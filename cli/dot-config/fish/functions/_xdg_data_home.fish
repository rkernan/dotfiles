function _xdg_data_home --description "XDG_DATA_HOME or default"
  if test -n "$XDG_DATA_HOME"
    printf $XDG_DATA_HOME
  else
    printf $HOME"/.local/share"
  end
end
