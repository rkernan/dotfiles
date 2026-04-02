set -U fisher_path (_xdg_config_home)"/fisher"
if test -d $fisher_path
  set -gp fish_function_path $fisher_path"/functions"
  set -gp fish_complete_path $fisher_path"/completions"
  for file in $fisher_path"/conf.d/"*".fish"
    source $file
  end
end
