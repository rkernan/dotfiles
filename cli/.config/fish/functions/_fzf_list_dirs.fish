function _fzf_list_dirs
  set -l dir $argv

  if test -q fd
    fd --type d --hidden --follow --strip-cwd-prefix $dir
  else
    find -L $dir -type d
  end
end
