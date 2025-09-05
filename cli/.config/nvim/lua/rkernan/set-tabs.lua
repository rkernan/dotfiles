local M = {}

---Summarize current tab setings
function M.summarize_tabs()
  vim.notify(string.format('shiftwidth = %d, tabstop = %d, expandtab = %s', vim.bo.shiftwidth, vim.bo.tabstop, vim.bo.expandtab), vim.log.levels.INFO)
end

---Set tab settings
---@param tabsize? integer Tab size, prompt if empty
---@param expandtab? boolean Expand tabs to spaces, prompt if empty
function M.set_tabs(tabsize, expandtab)
  tabsize = tabsize or tonumber(vim.fn.input('shiftwidth = '))
  expandtab = expandtab or (vim.fn.input('expandtab = [y/N] ') == 'y')

  if expandtab then
    vim.bo.shiftwidth = tabsize
    vim.bo.tabstop = 8
    vim.bo.expandtab = true
  else
    vim.bo.shiftwidth = 0
    vim.bo.tabstop = tabsize
    vim.bo.expandtab = false
  end
end

return M
