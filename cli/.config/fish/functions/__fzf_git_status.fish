function __fzf_git_status -d "Fuzzy select git unstaged and untracked changes"
    if ! __fish_is_git_repository
        return
    end

    set -l fzf_git_status_command 'git -c color.status=always status --short'
    set -l fzf_preview 'git diff --color HEAD -- {-1}'

    eval $fzf_git_status_command | eval (__fzfcmd_with_preview $fzf_preview)' -m --ansi' | awk '{print $2}' |
        while read -l r
            set result $result (string escape $r)
        end

    commandline -it -- (string join ' ' $result)
    commandline -f repaint
end
