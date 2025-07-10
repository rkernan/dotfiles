local utils = require('heirline.utils')

local function setup_colors()
  local base_colors = {
    black          = vim.g.terminal_color_0,
    red            = vim.g.terminal_color_1,
    green          = vim.g.terminal_color_2,
    yellow         = vim.g.terminal_color_3,
    blue           = vim.g.terminal_color_4,
    magenta        = vim.g.terminal_color_5,
    cyan           = vim.g.terminal_color_6,
    white          = vim.g.terminal_color_7,
  }
  -- terminal colors may not be defined, fallback
  if base_colors.black == nil then base_colors.black = 'black' end
  if base_colors.red == nil then base_colors.red = 'red' end
  if base_colors.green == nil then base_colors.green = 'green' end
  if base_colors.yellow == nil then base_colors.yellow = 'yellow' end
  if base_colors.blue == nil then base_colors.blue = 'blue' end
  if base_colors.magenta == nil then base_colors.magenta = 'magenta' end
  if base_colors.cyan == nil then base_colors.cyan = 'cyan' end
  if base_colors.white == nil then base_colors.white = 'white' end

  local colors = vim.tbl_extend('error', {}, base_colors, {
    -- specials
    dim           = utils.get_highlight('Conceal').fg,
    file_modified = base_colors.green,
    recording_fg  = base_colors.black,
    recording_bg  = base_colors.green,
    bookmarks_fg  = base_colors.magenta,
    search_fg     = base_colors.black,
    search_bg     = base_colors.yellow,
    -- git
    git_head = base_colors.magenta,
    -- mini.diff
    minidiff_add    = utils.get_highlight('MiniDiffSignAdd').fg,
    minidiff_change = utils.get_highlight('MiniDiffSignChange').fg,
    minidiff_delete = utils.get_highlight('MiniDiffSignDelete').fg,
    -- diagnostics
    diagnostics_error = utils.get_highlight('DiagnosticSignError').fg,
    diagnostics_warn  = utils.get_highlight('DiagnosticSignWarn').fg,
    diagnostics_info  = utils.get_highlight('DiagnosticSignInfo').fg,
    diagnostics_hint  = utils.get_highlight('DiagnosticSignHint').fg,
    -- mode colors
    mode_fg          = base_colors.black,
    mode_normal_bg   = base_colors.white,
    mode_visual_bg   = base_colors.red,
    mode_replace_bg  = base_colors.red,
    mode_insert_bg   = base_colors.blue,
    mode_terminal_bg = base_colors.yellow,
    mode_command_bg  = base_colors.green,
  })

  -- may be undefined
  if colors.minidiff_add == nil then colors.minidiff_add = base_colors.green end
  if colors.minidiff_change == nil then colors.minidiff_change = base_colors.blue end
  if colors.minidiff_delete == nil then colors.minidiff_delete = base_colors.red end

  return colors
end

return { setup_colors = setup_colors }
