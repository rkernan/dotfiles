local wezterm = require('wezterm')

local DEFAULT_WORKSPACE = 'default'

local function tab_index(tab)
  return tab.tab_index + 1
end

local function tab_title(tab)
  if tab.tab_title and #tab.tab_title > 0 then
    return tab.tab_title
  end
  return tab.active_pane.title
end

local function zoom_icon(tab)
  if tab.active_pane.is_zoomed then
    return ' '
  else
    return ' '
  end
end

local function tab_full_title(tab)
  return tab_index(tab) .. ': ' .. zoom_icon(tab) .. tab_title(tab)
end

wezterm.on(
  'format-tab-title',
  function (tab, _, _, _, _, max_width)
    return ' ' .. wezterm.truncate_right(tab_full_title(tab), max_width) .. ' '
  end
)

wezterm.on('update-right-status', function (window)
  local active_workspace = window:active_workspace()
  if active_workspace == DEFAULT_WORKSPACE then
    window:set_right_status('')
  else
    window:set_right_status(' ' .. active_workspace .. ' ')
  end
end)

local config = wezterm.config_builder()
config.font = wezterm.font('JetBrainsMono Nerd Font Mono')
config.font_size = 10.5
config.color_scheme = 'gruvbones-dark'

config.default_domain = os.getenv('WEZTERM_DEFAULT_DOMAIN') or 'local'
config.default_workspace = DEFAULT_WORKSPACE

config.unix_domains = {
  {
    name = 'unix',
  },
}
config.default_gui_startup_args = { 'connect', 'unix' }

config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.tab_max_width = 50

config.disable_default_key_bindings = true
config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
  -- clipboard
  { key = 'C', mods = 'CTRL', action = wezterm.action.CopyTo('ClipboardAndPrimarySelection') },
  { key = 'V', mods = 'CTRL', action = wezterm.action.PasteFrom('Clipboard') },
  -- scrollback
  { key = 'PageUp',   action = wezterm.action.ScrollByPage(-1) },
  { key = 'PageDown', action = wezterm.action.ScrollByPage(1) },
  { key = 'Home',     action = wezterm.action.ScrollToTop },
  { key = 'End',      action = wezterm.action.ScrollToBottom },
  -- font size
  { key = '=', mods = 'CTRL', action = wezterm.action.IncreaseFontSize },
  { key = '-', mods = 'CTRL', action = wezterm.action.DecreaseFontSize },
  { key = '0', mods = 'CTRL', action = wezterm.action.ResetFontSize },
  -- tabs
  { key = 'c', mods = 'LEADER', action = wezterm.action.SpawnTab('CurrentPaneDomain') },
  { key = 'X', mods = 'LEADER', action = wezterm.action.CloseCurrentTab({ confirm = true }) },
  { key = 'n', mods = 'LEADER', action = wezterm.action.ActivateTabRelative(1) },
  { key = 'p', mods = 'LEADER', action = wezterm.action.ActivateTabRelative(-1) },
  { key = '1', mods = 'LEADER', action = wezterm.action.ActivateTab(0) },
  { key = '2', mods = 'LEADER', action = wezterm.action.ActivateTab(1) },
  { key = '3', mods = 'LEADER', action = wezterm.action.ActivateTab(2) },
  { key = '4', mods = 'LEADER', action = wezterm.action.ActivateTab(3) },
  { key = '5', mods = 'LEADER', action = wezterm.action.ActivateTab(4) },
  { key = '6', mods = 'LEADER', action = wezterm.action.ActivateTab(5) },
  { key = '7', mods = 'LEADER', action = wezterm.action.ActivateTab(6) },
  { key = '8', mods = 'LEADER', action = wezterm.action.ActivateTab(7) },
  { key = '9', mods = 'LEADER', action = wezterm.action.ActivateTab(8) },
  -- panes
  { key = 's', mods = 'LEADER', action = wezterm.action.SplitVertical({ domain = 'CurrentPaneDomain'}) },
  { key = 'v', mods = 'LEADER', action = wezterm.action.SplitHorizontal({ domain = 'CurrentPaneDomain' }) },
  { key = 'x', mods = 'LEADER', action = wezterm.action.CloseCurrentPane({ confirm = false }) },
  { key = 'h', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection('Left') },
  { key = 'j', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection('Down') },
  { key = 'k', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection('Up') },
  { key = 'l', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection('Right') },
  { key = 'z', mods = 'LEADER', action = wezterm.action.TogglePaneZoomState },
  { key = 'H', mods = 'LEADER', action = wezterm.action.AdjustPaneSize({ 'Left', 5 }) },
  { key = 'J', mods = 'LEADER', action = wezterm.action.AdjustPaneSize({ 'Down', 5 }) },
  { key = 'K', mods = 'LEADER', action = wezterm.action.AdjustPaneSize({ 'Up', 5 }) },
  { key = 'L', mods = 'LEADER', action = wezterm.action.AdjustPaneSize({ 'Right', 5 }) },
  -- copy mode
  { key = ']', mods = 'LEADER', action = wezterm.action.ActivateCopyMode },
  { key = '/', mods = 'LEADER', action = wezterm.action.Search('CurrentSelectionOrEmptyString') },
}

config.key_tables = {
  copy_mode = {
    { key = 'y', action = wezterm.action.Multiple({ wezterm.action.CopyTo('ClipboardAndPrimarySelection'), wezterm.action.CopyMode('Close') }) },
    { key = 'Escape', action = wezterm.action.CopyMode('Close') },
    { key = 'v', action = wezterm.action.CopyMode({ SetSelectionMode = 'Cell' })},
    { key = 'V', mods = 'SHIFT', action = wezterm.action.CopyMode({ SetSelectionMode = 'Line' })},
    { key = 'v', mods = 'CTRL', action = wezterm.action.CopyMode({ SetSelectionMode = 'Block' })},
    { key = 'h', action = wezterm.action.CopyMode('MoveLeft') },
    { key = 'j', action = wezterm.action.CopyMode('MoveDown') },
    { key = 'k', action = wezterm.action.CopyMode('MoveUp') },
    { key = 'l', action = wezterm.action.CopyMode('MoveRight') },
    { key = 'w', action = wezterm.action.CopyMode('MoveForwardWord') },
    { key = 'b', action = wezterm.action.CopyMode('MoveBackwardWord') },
    { key = 'e', action = wezterm.action.CopyMode('MoveForwardWordEnd') },
    { key = '0', action = wezterm.action.CopyMode('MoveToStartOfLine') },
    { key = '$', action = wezterm.action.CopyMode('MoveToEndOfLineContent') },
    { key = '^', action = wezterm.action.CopyMode('MoveToStartOfLineContent') },
    { key = 'G', action = wezterm.action.CopyMode('MoveToScrollbackBottom') },
    { key = 'g', action = wezterm.action.CopyMode('MoveToScrollbackBottom') },
    { key = 'h', mods = 'SHIFT', action = wezterm.action.CopyMode('MoveToViewportTop') },
    { key = 'm', mods = 'SHIFT', action = wezterm.action.CopyMode('MoveToViewportMiddle') },
    { key = 'l', mods = 'SHIFT', action = wezterm.action.CopyMode('MoveToViewportBottom') },
    { key = 'b', mods ='CTRL', action = wezterm.action.CopyMode('PageUp') },
    { key = 'f', mods ='CTRL', action = wezterm.action.CopyMode('PageDown') },
    { key = 'u', mods ='CTRL', action = wezterm.action.CopyMode({ MoveByPage = -0.5 }) },
    { key = 'd', mods ='CTRL', action = wezterm.action.CopyMode({ MoveByPage = 0.5 }) },
    { key = '/', action = wezterm.action.CopyMode('EditPattern') },
    { key = 'n', action = wezterm.action.CopyMode('NextMatch') },
    { key = 'N', action = wezterm.action.CopyMode('PriorMatch') },
  },
  search_mode = {
    { key = 'Enter', action = wezterm.action.CopyMode('AcceptPattern') },
    { key = 'Escape', action = wezterm.action.CopyMode('Close') },
  }
}

return config
