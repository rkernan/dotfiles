function __fzf_git_branch -d "Fuzzy select git branch"
    if ! __fish_is_git_repository
        return
    end

    set -l fzf_query (__fzf_parse_commandline)[2]
    set -l fzf_git_branch_command 'git branch --format "%(refname:short)"'
    set -l fzf_preview 'git log --color {} 2> /dev/null'

    eval $fzf_git_branch_command | eval (__fzfcmd_with_preview $fzf_preview)' -m --query="'$fzf_query'"' | 
        while read -l r
            set result $result (string escape $r)
        end

    commandline -it -- (string join ' ' $result)
    commandline -f repaint
end
