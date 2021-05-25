function fzf-kill -d "Fuzzy kill processes"
    set -l uid (id -u)
    if test $uid -eq 0
        set procs (ps -ef | sed 1d | fzf -m | awk '{print $2}')
    else
        set procs (ps -f -u $uid | sed 1d | fzf -m | awk '{print $2}')
    end

    if test -z "$procs"
        return 1
    end

    kill $argv[1] $procs
end
