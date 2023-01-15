vim.keymap.set({ 'n', 'x', 'o' }, '*', [[<Plug>(asterisk-z*)]], { desc = 'Search word' })
vim.keymap.set({ 'n', 'x', 'o' }, '#', [[<Plug>(asterisk-z#)]], { desc = 'Search word backwards' })
vim.keymap.set({ 'n', 'x', 'o' }, 'g*', [[<Plug>(asterisk-gz*)]], { desc = 'Search sub-word' })
vim.keymap.set({ 'n', 'x', 'o' }, 'g#', [[<Plug>(asterisk-gz#)]], { desc = 'Search sub-word backwards' })
