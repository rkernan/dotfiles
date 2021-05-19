function fzf-ssh --argument-names 'user' --description "Fuzzy ssh"
    set -l res (cat ~/.hosts | column -t | fzf | awk '{print $1}')

    if test -z "$res"
        return 1
    end

    if test -n "$user"
        commandline -i -- (printf 'ssh %s@%s' $user $res)
        commandline -f repaint
    else
        commandline -i -- (printf 'ssh %s' $res)
        commandline -f repaint
        commandline -C 4
    end
end
