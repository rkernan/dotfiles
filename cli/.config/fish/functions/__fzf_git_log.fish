function __fzf_git_log -d "Fuzzy select git commits"
    if ! __fish_is_git_repository
        return
    end

    set -l fzf_git_log_command 'git log --color'
    set -l fzf_preview 'git show --color {1}'

    eval $fzf_git_log_command | eval (__fzfcmd_with_preview $fzf_preview)' -m --ansi' | awk '{print $1}' |
        while read -l r
            set result $result (string escape $r)
        end

    commandline -it -- (string join ' ' $result)
    commandline -f repaint
end
