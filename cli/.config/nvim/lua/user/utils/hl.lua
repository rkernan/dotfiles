local M = {}

function M.get_hl(hlname)
  local _, hl = pcall(function () return vim.api.nvim_get_hl_by_name(hlname, true) end)
  return {
    bg = (hl and hl.background) and string.format("#%06x", hl.background) or nil,
    fg = (hl and hl.foreground) and string.format("#%06x", hl.foreground) or nil,
  }
end

function M.get_termhl(num)
  local key = 'terminal_color_' .. num
  return vim.g[key] and vim.g[key] or nil
end

return M
