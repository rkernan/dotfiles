vim.keymap.set({ 'n', 'v', 'o' }, '*', [[<Plug>(asterisk-z*)]], { desc = 'Search word' })
vim.keymap.set({ 'n', 'v', 'o' }, '#', [[<Plug>(asterisk-z#)]], { desc = 'Search word backwards' })
vim.keymap.set({ 'n', 'v', 'o' }, 'g*', [[<Plug>(asterisk-gz*)]], { desc = 'Search sub-word' })
vim.keymap.set({ 'n', 'v', 'o' }, 'g#', [[<Plug>(asterisk-gz#)]], { desc = 'Search sub-word backwards' })
