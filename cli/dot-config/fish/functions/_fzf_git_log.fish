function _fzf_git_log
  if ! __fish_is_git_repository
    return
  end

  git log --color |
  fzf --height=100% --prompt='git-log> ' --query=(commandline -t) -m --ansi |
  awk '{print $1}' |
  while read -l r
    set -f result $result (git rev-parse (string escape $r))
  end

  commandline -rt -- (string join ' ' $result)
  commandline -f repaint
end
