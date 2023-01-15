-- disable ex mode mapping
vim.keymap.set('n', 'Q', function () end)

-- yank to end of line
vim.keymap.set('n', 'Y', 'y$')

-- treat lines wraps as real lines
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')
vim.keymap.set('n', 'gj', 'j', { desc = 'Next line' })
vim.keymap.set('n', 'gk', 'k', { desc = 'Prev line' })

-- keep highlight after changing indent
vim.keymap.set('v', '>', '>gv')
vim.keymap.set('v', '<', '<gv')

-- automatically jump to the end of the last paste
vim.keymap.set('v', 'y', 'y`]')
vim.keymap.set({ 'n', 'v' }, 'p', 'p`]')