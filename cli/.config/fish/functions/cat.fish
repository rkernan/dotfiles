function cat
  if type -q bat
    command bat --style=plain $argv
  else
    command cat $argv
  end
end
