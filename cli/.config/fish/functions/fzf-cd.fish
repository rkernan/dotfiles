function fzf-cd --description "Fuzzy change directory"
    set -l searchdir "."
    if set -q argv[1]
        set searchdir $argv[1]
    end

    set -l destdir (find $searchdir -mindepth 1 -type d 2>/dev/null | uniq | fzf)
    if test -z $destdir
        return 1
    end

    cd $destdir
end
