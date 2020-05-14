function fzf_edit --description "Fuzzy edit file(s)"
    set -l destfiles (rg --hidden --files --no-ignore --follow . 2>/dev/null | fzf -m --preview="cat {}")
    if test -z $destfiles
        return 1
    end
    $EDITOR $destfiles
end
