function _fzy_history
  commandline -rt -- (history | fzy --prompt='history> ' --query=(commandline))
  commandline -f repaint
end
