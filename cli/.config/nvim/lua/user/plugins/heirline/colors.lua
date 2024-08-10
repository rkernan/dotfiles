local utils = require('heirline.utils')

local function setup_colors()
  return {
    dim           = utils.get_highlight('Conceal').fg,
    file_modified = vim.g.terminal_color_2, -- green
    recording_fg  = vim.g.terminal_color_0, -- black
    recording_bg  = vim.g.terminal_color_2, -- green
    -- gitsigns
    gitsigns_head    = vim.g.terminal_color_5, -- magenta
    gitsigns_added   = utils.get_highlight('GitSignsAdd').fg,
    gitsigns_changed = utils.get_highlight('GitSignsChange').fg,
    gitsigns_deleted = utils.get_highlight('GitSignsDelete').fg,
    -- diagnostics
    diagnostics_error = utils.get_highlight('DiagnosticSignError').fg,
    diagnostics_warn  = utils.get_highlight('DiagnosticSignWarn').fg,
    diagnostics_info  = utils.get_highlight('DiagnosticSignInfo').fg,
    diagnostics_hint  = utils.get_highlight('DiagnosticSignHint').fg,
    -- codeaction
    codeaction = vim.g.terminal_color_3, -- yellow
    -- mode colors
    mode_fg          = vim.g.terminal_color_0, -- black
    mode_normal_bg   = vim.g.terminal_color_7, -- white
    mode_visual_bg   = 'orange',
    mode_replace_bg  = vim.g.terminal_color_1, -- red
    mode_insert_bg   = vim.g.terminal_color_4, -- blue
    mode_terminal_bg = vim.g.terminal_color_3, -- yellow
    mode_command_bg  = vim.g.terminal_color_2, -- green
  }
end

return { setup_colors = setup_colors }
