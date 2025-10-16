function _list_files --description "list files under cwd"
  set -l dir $argv
  if type -q fd
    fd --type f --hidden --follow $dir
  else
    find -L $dir -type f -not -path '*/\.git/*'
  end
end
