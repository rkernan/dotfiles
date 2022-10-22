function _expand_bang
    switch (commandline --current-token)
      case '!'
        commandline --current-token $history[1]
        commandline --function repaint
      case '*'
        commandline --insert '!'
    end
end
