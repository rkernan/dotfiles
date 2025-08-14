local function summarize_tabs()
  vim.notify(string.format('shiftwidth = %d, tabstop = %d, expandtab = %s', vim.bo.shiftwidth, vim.bo.tabstop, vim.bo.expandtab), vim.log.levels.INFO)
end

local function set_tabs()
  local tabsize = tonumber(vim.fn.input('shiftwidth = '))
  local expandtab = (vim.fn.input('expandtab = [y/N] ') == 'y')

  if expandtab then
    vim.bo.shiftwidth = tabsize
    vim.bo.tabstop = 8
    vim.bo.expandtab = true
  else
    vim.bo.shiftwidth = 0
    vim.bo.tabstop = tabsize
    vim.bo.expandtab = false
  end

  summarize_tabs()
end

vim.api.nvim_create_user_command('SummarizeTabs', summarize_tabs, { nargs = 0, bang = true})
vim.api.nvim_create_user_command('SetTabs', set_tabs, { nargs = 0, bang = true })
