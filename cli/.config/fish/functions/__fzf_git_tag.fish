function __fzf_git_tag -d "Fuzzy select git tags"
    __fish_is_git_repository; or return

    set -l fzf_git_tag_command 'git tag --sort -version:refname'
    set -l fzf_preview 'git show --color {}'

    eval $fzf_git_tag_command | eval (__fzfcmd_with_preview $fzf_preview)' -m' |
        while read -l r
            set result $result (string escape $r)
        end

    commandline -it -- (string join ' ' $result)
    commandline -f repaint
end
