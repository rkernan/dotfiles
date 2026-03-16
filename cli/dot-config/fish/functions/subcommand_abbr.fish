function subcommand_abbr -a cmd short long
  if not string match --regex --quiet '^[a-zA-Z0-9]+$' $short
    echo "subcommand_abbr validation error: $short -> $long"
    return 1
  end

  set -l abbr_fn_name (string join "_" "abbr" "$cmd" "$short")
  set -l abbr_fn "
function $abbr_fn_name
  set --local tokens (commandline --tokenize)
  if test \$tokens[1] = \"$cmd\"
    echo $long
  else
    echo $short
  end
end
abbr --add $short --position anywhere --function $abbr_fn_name
  "
  eval "$abbr_fn"
end
