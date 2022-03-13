set -q _fisher_path_initialized && exit
set -g _fisher_path_initialized

if test -z "$fisher_path" || test "$fisher_path" = "$__fish_config_dir"
    exit
end

if status is-interactive && not test -f $fisher_path"/functions/fisher.fish"
    # automatically install fisher
    curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
    # FIXME https://github.com/jorgebucaran/fisher/issues/705
    echo "Fisher install clobbers fish_plugins... Run the following:"
    echo "> git checkout fish_plugins"
    echo "> cat fish_plugins | fisher install"
end

set fish_complete_path $fish_complete_path[1] $fisher_path/completions $fish_complete_path[2..]
set fish_function_path $fish_function_path[1] $fisher_path/functions $fish_function_path[2..]

for file in $fisher_path/conf.d/*.fish
    if ! test -f (string replace -r "^.*/" $__fish_config_dir/conf.d/ -- $file)
        and test -f $file && test -r $file
        source $file
    end
end
