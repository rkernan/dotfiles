function __git_fzf_git_tag --description "Fuzzy select git tags"
    if ! __fish_is_git_repository
        return
    end

    set -l preview
    if __fzf_show_preview
        set "git show {} | head -"(__fzf_num_preview_lines)
    end

    git tag --sort -version:refname | fzf -m --ansi --preview "$preview"
    commandline -f repaint
end
