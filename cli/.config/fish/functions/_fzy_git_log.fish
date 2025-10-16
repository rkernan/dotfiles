function _fzy_git_log
  if ! __fish_is_git_repository
    return
  end
  set -f result (git log | fzy --prompt='git-log> ' --query=(commandline -t) | awk '{print $1}')
  commandline -rt -- (git rev-parse $result)
  commandline -f repaint
end
