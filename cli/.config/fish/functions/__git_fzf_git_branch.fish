function __git_fzf_git_branch -d "Fuzzy select git branch"
    if ! __fish_is_git_repository
        return
    end

    set -l preview
    if __fzf_show_preview
        set preview "git log --oneline --graph --date=short --pretty='format:%cd %h%d %s [%an]t' (echo {} | sed s/^..// | cut -d' ' -f1) | head -"(__fzf_preview_height)
    end

    set -l res (git branch -a | \
                grep -v '/HEAD\s' | \
                fzf -m --ansi --preview "$preview" | \
                sed 's/^..//' | \
                cut -d' ' -f1 | \
                sed 's#^remotes/##')

    if test -z "$res"
        return 1
    end

    commandline -i -- (printf '%s ' (string join ' ' $res))
    commandline -f repaint
end
