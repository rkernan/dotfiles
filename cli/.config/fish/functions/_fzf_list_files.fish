function _fzf_list_files
  set -l dir $argv

  if type -q fd
    fd --type f --hidden --follow --strip-cwd-prefix $dir
  else
    find -L $dir -type f -not -path '*/\.git/*' -printf '%P\n'
  end
end
