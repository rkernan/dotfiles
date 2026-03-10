function _list_dirs --description "list directories under cwd"
  set -l dir $argv
  if type -q fd
    fd --type d --hidden --follow $dir
  else
    find -L $dir -mindepth 1 -type d
  end
end
