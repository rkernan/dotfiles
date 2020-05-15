function __git_fzf_git_branch --description "Fuzzy select git branch"
    if ! __fish_is_git_repository
        return
    end

    set -l preview
    if __fzf_show_preview
        set preview "git log --oneline --graph --date=short --pretty='format:%cd %h%d %s [%an]t' (echo {} | sed s/^..// | cut -d' ' -f1) | head -"(__fzf_preview_height)
    end

    git branch -a | grep -v '/HEAD\s' | fzf -m --ansi --preview "$preview" | sed 's/^..//' | cut -d' ' -f1 | sed 's#^remotes/##'
    commandline -f repaint
end
