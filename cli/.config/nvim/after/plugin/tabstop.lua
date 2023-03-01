local function summarize_tabs()
  vim.notify('shiftwidth = ' .. vim.bo.shiftwidth)
  vim.notify('tabstop = ' .. vim.bo.tabstop)
  vim.notify('expandtab = ' .. tostring(vim.bo.expandtab))
end

local function set_tabs()
  -- set shiftwidth
  vim.bo.shiftwidth = tonumber(vim.fn.input('shiftwidth = '))
  vim.notify('\n\r')
  -- set expandtab
  vim.bo.expandtab = (vim.fn.input('expandtab = [y/N] ') == 'y')
  vim.notify('\n\r')
  -- set tabstop - 8 for soft-tabs, shiftwidth for hard-tabs
  if vim.bo.expandtab then
    vim.bo.tabstop = 8
  else
    vim.bo.tabstop = vim.bo.shiftwidth
  end
  -- print summary
  summarize_tabs()
end

vim.api.nvim_create_user_command('SummarizeTabs', summarize_tabs, { nargs = 0, bang = true})
vim.api.nvim_create_user_command('SetTabs', set_tabs, { nargs = 0, bang = true })
