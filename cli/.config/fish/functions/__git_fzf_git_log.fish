function __git_fzf_git_log --description "Fuzzy select git commits"
    if ! __fish_is_git_repository
        return
    end

    set -l preview
    if __fzf_show_preview
        set preview "git show (echo {} | grep -o '[a-f0-9]\{7,\}' | head -1) | head -"(__fzf_preview_height)
    end

    git log --color=always --graph --date=short --format="%C(auto)%cd %h%d %s %C(magenta)[%an]%Creset" | \
        fzf -m --ansi --preview "$preview" | \
        sed -E 's/.*([a-f0-9]{7,}).*/\1/'
    commandline -f repaint
end
