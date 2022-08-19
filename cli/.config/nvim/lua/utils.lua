local M = {}

function M.enable_unicode()
  local no_unicode = tonumber(vim.env.NO_UNICODE)
  if no_unicode == 0 then
    return true
  else
    return false
  end
end

function M.is_win_floating(winnr)
  local cfg = vim.api.nvim_win_get_config(winnr)
  return not (cfg.relative == nil or cfg.relative == '')
end

function M.setlocal_no_float(opts)
  local winnr = 0
  if M.is_win_floating(winnr) then return end
  vim.cmd('setlocal ' .. table.concat(opts, ' '))
end

return M
