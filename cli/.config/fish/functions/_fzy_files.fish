function _fzy_files
  commandline -rt -- (_list_files | fzy --prompt='files> ' --query=(commandline -t))
  commandline -f repaint
end
