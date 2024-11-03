local utils = require('heirline.utils')

local function setup_colors()
  return {
    black          = vim.g.terminal_color_0,
    red            = vim.g.terminal_color_1,
    green          = vim.g.terminal_color_2,
    yellow         = vim.g.terminal_color_3,
    blue           = vim.g.terminal_color_4,
    magenta        = vim.g.terminal_color_5,
    cyan           = vim.g.terminal_color_6,
    white          = vim.g.terminal_color_7,
    bright_black   = vim.g.terminal_color_8,
    bright_red     = vim.g.terminal_color_9,
    bright_green   = vim.g.terminal_color_10,
    bright_yellow  = vim.g.terminal_color_11,
    bright_blue    = vim.g.terminal_color_12,
    bright_magenta = vim.g.terminal_color_13,
    bright_cyan    = vim.g.terminal_color_14,
    bright_white   = vim.g.terminal_color_15,
    -- specials
    dim           = utils.get_highlight('Conceal').fg,
    file_modified = vim.g.terminal_color_2, -- green
    recording_fg  = vim.g.terminal_color_0, -- black
    recording_bg  = vim.g.terminal_color_2, -- green
    -- mini.diff
    minidiff_add    = utils.get_highlight('MiniDiffSignAdd').fg,
    minidiff_change = utils.get_highlight('MiniDiffSignChange').fg,
    minidiff_delete = utils.get_highlight('MiniDiffSignDelete').fg,
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
    mode_visual_bg   = vim.g.terminal_color_1, -- red
    mode_replace_bg  = vim.g.terminal_color_1, -- red
    mode_insert_bg   = vim.g.terminal_color_4, -- blue
    mode_terminal_bg = vim.g.terminal_color_3, -- yellow
    mode_command_bg  = vim.g.terminal_color_2, -- green
  }
end

return { setup_colors = setup_colors }
