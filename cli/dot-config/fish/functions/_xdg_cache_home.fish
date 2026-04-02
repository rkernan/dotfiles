function _xdg_cache_home --description "XDG_CACHE_HOME or default"
  if test -n "$XDG_CACHE_HOME"
    printf $XDG_CACHE_HOME
  else
    printf $HOME"/.cache"
  end
end
