local augroup = vim.api.nvim_create_augroup('user.autocmds', { clear = true })

-- resize windows automatically
vim.api.nvim_create_autocmd('VimResized', { group = augroup, command = 'wincmd =' })

-- restore last cursor position
vim.api.nvim_create_autocmd('BufReadPost', {
  group = augroup,
  pattern = { '*' },
  callback = function ()
    vim.cmd([[silent! normal! g`"zv]])
  end
})
