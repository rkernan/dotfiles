-- vim.g.asterisk['keeppos'] = true

vim.keymap.set({ 'n', 'v', 'o' }, '*', '<Plug>(asterisk-z*)')
vim.keymap.set({ 'n', 'v', 'o' }, '#', '<Plug>(asterisk-z#)')
vim.keymap.set({ 'n', 'v', 'o' }, 'g*', '<Plug>(asterisk-gz*)')
vim.keymap.set({ 'n', 'v', 'o' }, 'g#', '<Plug>(asterisk-gz#)')
