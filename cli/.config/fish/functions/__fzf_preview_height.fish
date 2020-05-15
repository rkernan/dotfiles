function __fzf_preview_height --description "The number of lines in the FZF preview"
    echo (math (tput lines) - 2) # sans border lines
end
