local M = {}

function M.reset_win_cache(o)
  o._win_cache = nil
  vim.schedule(function () vim.cmd.redrawstatus() end)
end

return M
