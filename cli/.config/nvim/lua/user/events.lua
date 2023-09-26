local augroup = vim.api.nvim_create_augroup('core', { clear = true })

-- resize windows automatically
vim.api.nvim_create_autocmd('VimResized', { group = augroup, command = 'wincmd =' })
