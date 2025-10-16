function _fzy_dirs
  commandline -rt -- (_list_dirs | fzy --prompt='dirs> ' --query=(commandline -t))
  commandline -f repaint
end
