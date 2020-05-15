function __git_fzf_git_status --description "Fuzzy select git unstaged and untracked changes"
    if ! __fish_is_git_repository
        return
    end

    set -l preview
    if __fzf_show_preview
        set preview "git --no-color diff HEAD -- {-1} | head -"(__fzf_preview_height)
    end

    git -c color.status=always status --short | fzf -m --ansi --preview "$preview" | cut -c4- | sed 's/.* -> //'
    commandline -f repaint
end
