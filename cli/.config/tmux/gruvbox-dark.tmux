# default statusbar colors
set-option -g status-style "bg=colour237,fg=colour223"
# default window title colors
set-window-option -g window-status-style "bg=colour214,fg=colour37"
# default window with an activity alert
set-window-option -g window-status-activity-style "bg=colour237,fg=colour248"
# active window title colors
set-window-option -g window-status-current-style "bg=red,fg=colour237"
# pane border
set-option -g pane-active-border-style "fg=colour250"
set-option -g pane-border-style "fg=colour237"
# message infos
set-option -g message-style "bg=colour239,fg=colour223"
# writing commands interactive
set-option -g message-command-style "bg=colour239,fg=colour223"
# pane number display
set-option -g display-panes-active-colour "colour250"
set-option -g display-panes-colour "colour237"
# clock
set-option -g clock-mode-colour "colour109"
# bell
set-option -g window-status-bell-style "bg=colour167,fg=colour235"
# theme settings
set-option -g status on
set-option -g monitor-activity on
set-option -g status-justify "left"
set-option -g status-left-style none
set-option -g status-left-length 80
set-option -g status-right-style none
set-option -g status-right-length 80
set-window-option -g window-status-separator ""
set-option -g status-left "#[bg=colour248,fg=colour237] #S "
set-option -g status-right "#[bg=colour248,fg=colour237] #h "
set-window-option -g window-status-current-format "#[bg=colour214,fg=colour239] #I#{?window_zoomed_flag,+,}#{?window_name,: ,}#{?window_name,#{window_name},} "
set-window-option -g window-status-format "#[bg=colour239,fg=colour223]#{?window_activity_flag,#[bg=red],} #I#{?window_name,: ,}#{?window_name,#{window_name},} "
