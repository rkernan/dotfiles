local M = {}

function M.summarize_tabs()
  vim.notify('shiftwidth = ' .. vim.bo.shiftwidth)
  vim.notify('tabstop = ' .. vim.bo.tabstop)
  vim.notify('expandtab = ' .. tostring(vim.bo.expandtab))
end

function M.set_tabs()
  -- set shiftwidth
  vim.bo.shiftwidth = tonumber(vim.fn.input('shiftwidth = '))
  vim.notify('\n\r')
  -- set expandtab
  vim.bo.expandtab = (vim.fn.input('expandtab = [y/N] ') == 'y')
  vim.notify('\n\r')
  -- set tabstop - 8 for soft-tabs, shiftwidth for hard-tabs
  if vim.bo.expandtab then
    vim.bo.tabstop= 8
  else
    vim.bo.tabstop = vim.bo.shiftwidth
  end
  -- print summary
  M.summarize_tabs()
end

vim.cmd("command! -nargs=0 SummarizeTabs lua require('tabs').summarize_tabs()")
vim.cmd("command! -nargs=0 SetTabs lua require('tabs').set_tabs()")

return M
