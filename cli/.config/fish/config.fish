set -x GOPATH ~/Workspace/go

set -g fish_user_paths ~/.local/bin ~/.linuxbrew/bin /home/linuxbrew/.linuxbrew/bin ~/.cargo.bin $GOPATH/bin $fish_user_paths

set -x EDITOR nvim
set -x PAGER less

set -q NO_UNICODE || set -x NO_UNICODE 0

if test $NO_UNICODE -gt 0
    set -x FZF_DEFAULT_OPTS --layout=reverse --prompt="> " --pointer=">" --marker="<"
else
    set -x FZF_DEFAULT_OPTS --layout=reverse --prompt="❯ " --pointer="❯" --marker="❯"
end

if type -q rg
    set -x FZF_DEFAULT_COMMAND "rg --files --no-ignore --hidden --follow"
else
    set -x FZF_DEFAULT_COMMAND "find -L . -type f"
end

abbr e $EDITOR
abbr p $PAGER

abbr fcd    fzf-cd
abbr fe     fzf-edit
abbr fkill  fzf-kill

set fish_color_command normal
set fish_color_redirection brblack --bold
set fish_color_end brblack --bold
set fish_color_param normal
