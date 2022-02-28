local M = {}

function M.summarize_tabs()
  vim.notify('tabstop = ' .. vim.bo.tabstop)
  if vim.bo.softtabstop > 0 then vim.notify('softtabstop = ' .. vim.bo.softtabstop) end
  if vim.bo.shiftwidth > 0 then vim.notify('shiftwidth = ' .. vim.bo.shiftwidth) end
  vim.notify('expandtab = ' .. tostring(vim.bo.expandtab))
end

function M.set_tabs()
  -- set tabs
  vim.bo.tabstop = tonumber(vim.fn.input('tabstop = softtabstop = shiftwidth = '))
  vim.notify('\n\r')
  vim.bo.softtabstop = 0
  vim.bo.shiftwidth = 0
  -- set expandtab
  vim.bo.expandtab = (vim.fn.input('expandtab = [y/N] ') == 'y')
  vim.notify('\n\r')
  -- print summary
  M.summarize_tabs()
end

-- register vim commands
vim.cmd([[ command! -nargs=0 SummarizeTabs lua require('tabs').summarize_tabs() ]])
vim.cmd([[ command! -nargs=0 SetTabs lua require('tabs').set_tabs() ]])

return M
