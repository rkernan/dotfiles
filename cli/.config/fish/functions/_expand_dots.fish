function _expand_dots
    set -l cmd (commandline --cut-at-cursor)
    set -l split (string split ' ' $cmd)
    switch $split[-1]
        case './*'
          commandline --insert '.'
        case '*..'
          commandline --insert '/..'
        case '*'
          commandline --insert '.'
    end
end
