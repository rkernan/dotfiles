set -x GOPATH ~/Workspace/go

fish_add_path $GOPATH/bin
fish_add_path $HOME/.cargo/bin
fish_add_path /home/linuxbrew/.linuxbrew/sbin
fish_add_path /home/linuxbrew/.linuxbrew/bin
fish_add_path $HOME/.local/bin

if set -q AUTOSTART_TMUX
and test $AUTOSTART_TMUX -gt 0
and type -q tmux
and status is-interactive
and not set -q TMUX
    set --local session 0

    if not tmux has-session -t $session
        tmux new-session -s $session
    end
    exec tmux attach-session -t $session
end

set -x EDITOR nvim
set -x PAGER less

# export environment - we're not the only one that needs this
set -q NO_UNICODE || set -x NO_UNICODE 0

if test $NO_UNICODE -gt 0
    set -x FZF_DEFAULT_OPTS "--layout=reverse --prompt='> ' --pointer='>' --marker='>'"
else
    set -x FZF_DEFAULT_OPTS "--layout=reverse --prompt='❯ ' --pointer='❯' --marker='❯'"
end

if type -q rg
    set -x FZF_DEFAULT_COMMAND "rg --files --no-ignore --hidden --follow"
else
    set -x FZF_DEFAULT_COMMAND "find -L . -type f"
end

abbr e $EDITOR
abbr p $PAGER

abbr cp cp -i
abbr ln ln -i
abbr mv mv -i
abbr rm rm -i

set fish_color_command normal
set fish_color_redirection brblack --bold
set fish_color_end brblack --bold
set fish_color_param normal

# sane umask
umask 0022
