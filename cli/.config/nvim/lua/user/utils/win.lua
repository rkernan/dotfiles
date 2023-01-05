local M = {}

function M.is_win_floating(winnr)
  local cfg = vim.api.nvim_win_get_config(winnr or 0)
  return not (cfg.relative == nil or cfg.relative == '')
end

return M
