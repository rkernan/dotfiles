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
    dim = utils.get_highlight('Conceal').fg,
    git_add = utils.get_highlight('GitSignsAdd').fg,
    git_change = utils.get_highlight('GitSignsChange').fg,
    git_del = utils.get_highlight('GitSignsDelete').fg,
    diag_err = utils.get_highlight('DiagnosticSignError').fg,
    diag_hint = utils.get_highlight('DiagnosticSignHint').fg,
    diag_info = utils.get_highlight('DiagnosticSignInfo').fg,
    diag_warn = utils.get_highlight('DiagnosticSignWarn').fg,
  }
end

return { setup_colors = setup_colors }
