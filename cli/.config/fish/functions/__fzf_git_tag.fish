function __fzf_git_tag -d "Fuzzy select git tags"
    if ! __fish_is_git_repository
        return
    end

    set -l preview
    if __fzf_show_preview
        set preview "git show {} | head -"(__fzf_preview_height)
    end

    set -l res (git tag --sort -version:refname | \
                fzf -m --ansi --preview "$preview")

    if test -z "$res"
        return 1
    end

    commandline -i -- (printf '%s ' (string join ' ' $res))
    commandline -f repaint
end
