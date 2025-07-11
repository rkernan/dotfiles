-- disable ex mode mapping
vim.keymap.set('n', 'Q', '<NOP>')

-- keep cursor centered
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- yank to system clipboard
vim.keymap.set({ 'n', 'v' }, '<Leader>y', '"+y', { desc = 'Yank to system clipboard' })

-- treat lines wraps as real lines
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')
vim.keymap.set('n', 'gj', 'j', { desc = 'Next line' })
vim.keymap.set('n', 'gk', 'k', { desc = 'Prev line' })

-- keep highlight after changing indent
vim.keymap.set('x', '>', '>gv')
vim.keymap.set('x', '<', '<gv')

-- inspect treesitter highlighting
vim.keymap.set('n', '<C-i>', function ()
  local res = vim.treesitter.get_captures_at_cursor(0)
  print(vim.inspect(res))
end, { desc = 'Highlight under cursor' })

-- open diagnostics in Floating window
vim.keymap.set('n', '<C-e>', function () vim.diagnostic.open_float() end, { desc = 'Open diagnostic float' })
