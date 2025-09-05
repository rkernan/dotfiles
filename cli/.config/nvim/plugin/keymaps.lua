vim.keymap.set('n', 'Q', '<NOP>', { desc = 'Disable ex-mode mapping' })
vim.keymap.set({ 'n', 'v' }, '<Leader>y', '"+y', { desc = 'Yank to system clipboard' })
vim.keymap.set('n', 'j', 'gj', { desc = 'Next line-wrap' })
vim.keymap.set('n', 'k', 'gk', { desc = 'Previous line-wrap' })
vim.keymap.set('n', 'gj', 'j', { desc = 'Next line' })
vim.keymap.set('n', 'gk', 'k', { desc = 'Previous line' })
vim.keymap.set('x', '>', '>gv', { desc = 'Increase indent' })
vim.keymap.set('x', '<', '<gv', { desc = 'Decrease indent' })

vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], { remap = true })
vim.keymap.set('t', '<C-]>', [[<C-\><C-n>]])

vim.keymap.set('n', '<Leader>f', function () require('mini.pick').builtin.files() end, { desc = 'Files' })
vim.keymap.set('n', '<Leader>b', function () require('mini.pick').builtin.buffers() end, { desc = 'Buffers' })

vim.keymap.set('n', '<Leader>e', function ()
  if #vim.fn.getloclist(0) == 0 then
    return
  end
  vim.cmd.lwindow()
end, { desc = 'Diagnostics' })

vim.keymap.set('n', '<Leader>/', ':silent grep! ', { desc = 'Grep' })
