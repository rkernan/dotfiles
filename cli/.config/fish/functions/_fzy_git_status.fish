function _fzy_git_status
  if ! __fish_is_git_repository
    return
  end
  set -f result (git status --short | fzy --prompt='git-status> ' --query=(commandline -t) | string split --no-empty ' ')
  if test (count $result) -eq 4
  and test "$result[3]"  = "->"
    commandline -rt -- $result[4]
  else
    commandline -rt -- $result[2]
  end
  commandline -f repaint
end
