function _fzf_list_dirs
  set -l dir $argv

  if type -q fd
    fd --type d --hidden --follow --strip-cwd-prefix $dir
  else
    find -L $dir -mindepth 1 -type d -printf '%P\n'
  end
end
