function __fish_uv_run_completions
  if set -q VIRTUAL_ENV
    and test -d "$VIRTUAL_ENV/bin"
    ls -1 "$VIRTUAL_ENV/bin"
  end
end

complete -c uv -n '__fish_seen_subcommand_from run; and __fish_is_nth_token 2' -a '(__fish_uv_run_completions)'
