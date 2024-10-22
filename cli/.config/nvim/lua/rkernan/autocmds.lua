local augroup = vim.api.nvim_create_augroup('rkernan.autocmds', { clear = true })

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

-- relativenumber in active windows
vim.api.nvim_create_autocmd({ 'BufEnter', 'FocusGained', 'InsertLeave', 'WinEnter'}, {
  group = augroup,
  callback = function ()
    vim.wo.relativenumber = true
  end
})
-- norelativenumber in inactive windows and insert mode
vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost', 'InsertEnter', 'WinLeave' }, {
  group = augroup,
  callback = function ()
    vim.wo.relativenumber = false
  end
})
