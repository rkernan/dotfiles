function _list_files --description "list files under cwd"
  if type -q fd
    fd --type f --hidden --follow --strip-cwd-prefix $argv
  else
    find -L $argv -type f -not -path '*/\.git/*'
  end
end
