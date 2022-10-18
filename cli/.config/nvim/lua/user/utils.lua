local M = {}

function M.is_win_floating(winnr)
  local cfg = vim.api.nvim_win_get_config(winnr or 0)
  return not (cfg.relative == nil or cfg.relative == '')
end

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

function M.has_value(tbl, value)
  for i = 0, #tbl do
    if tbl[i] == value then
      return true
    end
  end
  return false
end

function M.get_tbl_index(tbl, value)
  for i, v in ipairs(tbl) do
    if v == value then
      return i
    end
  end
end

return M
