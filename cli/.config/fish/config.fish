set -x GOPATH ~/Workspace/go

set -g fish_user_paths ~/.local/bin ~/.linuxbrew/bin /home/linuxbrew/.linuxbrew/bin ~/.cargo.bin $GOPATH/bin $fish_user_paths

set -x EDITOR nvim
set -x PAGER less

set -x FZF_DEFAULT_OPTS --layout=reverse --prompt="❯ " --pointer="❯" --marker="❯"
set -x FZF_DEFAULT_COMMAND "rg --files --no-ignore --hidden --follow"

abbr e $EDITOR
abbr p $PAGER

abbr fcd    fzf_cd
abbr fe     fzf_edit
abbr fkill  fzf_kill

set -e fish_mode_prompt
