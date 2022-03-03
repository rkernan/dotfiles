local M = {}

function M.create_augroup(autocmds, name)
  vim.cmd('augroup ' .. name)
  vim.cmd('autocmd!')
  for _, autocmd in ipairs(autocmds) do
    vim.cmd('autocmd ' .. table.concat(autocmd, ' '))
  end
  vim.cmd('augroup END')
end

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

return M
