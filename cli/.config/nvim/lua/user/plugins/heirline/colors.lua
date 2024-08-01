local utils = require('heirline.utils')

local function setup_colors()
  return {
    black = vim.g.terminal_color_0,
    red = vim.g.terminal_color_1,
    green = vim.g.terminal_color_2,
    yellow = vim.g.terminal_color_3,
    blue = vim.g.terminal_color_4,
    magenta = vim.g.terminal_color_5,
    cyan = vim.g.terminal_color_6,
    white = vim.g.terminal_color_7,
    bright_black = vim.g.terminal_color_8,
    bright_red = vim.g.terminal_color_9,
    bright_green = vim.g.terminal_color_10,
    bright_yellow = vim.g.terminal_color_11,
    bright_blue = vim.g.terminal_color_12,
    bright_magenta = vim.g.terminal_color_13,
    bright_cyan = vim.g.terminal_color_14,
    bright_white = vim.g.terminal_color_15,
    -- specialized colors
    file_modified = vim.g.terminal_color_2, -- green
    dim = utils.get_highlight('Conceal').fg,
    gitsigns_head = vim.g.terminal_color_5, -- magenta
    gitsigns_added = utils.get_highlight('GitSignsAdd').fg,
    gitsigns_changed = utils.get_highlight('GitSignsChange').fg,
    gitsigns_deleted = utils.get_highlight('GitSignsDelete').fg,
    diagnostics_error = utils.get_highlight('DiagnosticSignError').fg,
    diagnostics_warn = utils.get_highlight('DiagnosticSignWarn').fg,
    diagnostics_info = utils.get_highlight('DiagnosticSignInfo').fg,
    diagnostics_hint = utils.get_highlight('DiagnosticSignHint').fg,
  }
end

return { setup_colors = setup_colors }
