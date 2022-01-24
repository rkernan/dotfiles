function __fzf_git_status -d "Fuzzy select git unstaged and untracked changes"
    if ! __fish_is_git_repository
        return
    end

    set -l preview
    if __fzf_show_preview
        set preview "git diff HEAD -- {-1} | head -"(__fzf_preview_height)
    end

    set -l res (git -c color.status=always status --short | \
                fzf -m --ansi --preview "$preview" | \
                awk '{print $2}')

    if test -z "$res"
        return 1
    end

    commandline -i -- (printf '%s ' (string join ' ' $res))
    commandline -f repaint
end
