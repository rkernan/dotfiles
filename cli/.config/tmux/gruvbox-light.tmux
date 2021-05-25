# default statusbar colors
set-option -g status-style "bg=colour252,fg=colour239"
# default window title colors
set-window-option -g window-status-style "g=colour66,fg=colour229"
# default window with an activity alert
set-window-option -g window-status-activity-style "bg=colour237,fg=colour241"
# active window title colors
set-window-option -g window-status-current-style "bg=default,fg=colour237"
# pane border
set-option -g pane-active-border-style "fg=colour241"
set-option -g pane-border-style "fg=colour252"
# message infos
set-option -g message-style "bg=colour252,fg=colour241"
# writing commands interactive
set-option -g message-command-style "bg=colour124,fg=colour241"
# pane number display
set-option -g display-panes-active-colour "colour241"
set-option -g display-panes-colour "colour248"
# clock
set-option -g clock-mode-colour "colour172"
# bell
set-option -g window-status-bell-style "bg=colour124,fg=colour229"
# theme settings
set-option -g status on
set-option -g status-justify "left"
set-option -g status-left-style none
set-option -g status-left-length 80
set-option -g status-right-style none
set-option -g status-right-length 80
set-window-option -g window-status-separator ""
set-option -g status-left "#[bg=colour237,fg=colour255] #S "
set-option -g status-right "#[bg=colour237,fg=colour255] #h "
set-window-option -g window-status-current-format "#[bg=colour215,fg=colour239] #I#{?window_name,: ,}#[bold]#{?window_name,#{window_name},} "
set-window-option -g window-status-format "#[bg=colour249,fg=colour241] #I#{?window_name,: ,}#[bold]#{?window_name,#{window_name},} "
