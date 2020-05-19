function fzf-edit --description "Fuzzy edit file(s)"
    set -l preview
    if __fzf_show_preview
        set preview "head -"(__fzf_preview_height)" {}"
    end

    set -l destfiles (fzf -m --preview="$preview")
    if test -z $destfiles
        return 1
    end
    $EDITOR $destfiles
end
