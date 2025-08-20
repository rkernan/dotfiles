vim.keymap.set('n', 'Q', '<NOP>', { desc = 'Disable ex-mode mapping' })
vim.keymap.set({ 'n', 'v' }, '<Leader>y', '"+y', { desc = 'Yank to system clipboard' })
vim.keymap.set('n', 'j', 'gj', { desc = 'Next line-wrap' })
vim.keymap.set('n', 'k', 'gk', { desc = 'Previous line-wrap' })
vim.keymap.set('n', 'gj', 'j', { desc = 'Next line' })
vim.keymap.set('n', 'gk', 'k', { desc = 'Previous line' })
vim.keymap.set('x', '>', '>gv', { desc = 'Increase indent' })
vim.keymap.set('x', '<', '<gv', { desc = 'Decrease indent' })
vim.keymap.set('n', '<C-e>', function () vim.diagnostic.open_float() end, { desc = 'Open diagnostic float' })
vim.keymap.set('n', '<C-w>z', '<C-w>_<C-w>|', { desc = 'Zoom current window' })

vim.keymap.set('n', '<Leader>t', function ()
  if vim.g.terminal_tab then
    vim.cmd(string.format('tabnext %d | startinsert', vim.g.terminal_tab))
    return
  end
  vim.cmd('tabnew | startinsert | terminal')
  local index = vim.fn.tabpagenr()
  vim.g.terminal_tab = index
  local bufnr = vim.fn.tabpagebuflist(index)[vim.fn.tabpagewinnr(index)]
  vim.keymap.set('t', '<A-i>', function () vim.cmd('tabnext #') end, { buffer = bufnr })
  vim.api.nvim_create_autocmd('TabClosed', { buffer = bufnr, callback = function () vim.g.terminal_tab = nil end })
end, { desc = 'Persistent terminal' })
