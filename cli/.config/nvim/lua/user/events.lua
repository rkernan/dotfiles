local augroup = vim.api.nvim_create_augroup('core', { clear = true })

-- jump to last position on start
vim.api.nvim_create_autocmd('BufReadPost', {
  group = augroup,
  callback = function ()
    local row, _ = unpack(vim.api.nvim_buf_get_mark(0, '"'))
    local max_row = vim.fn.line('$')
    vim.api.nvim_win_set_cursor(0, { row <= max_row and row or max_row, 0 })
  end
})

-- resize windows automatically
vim.api.nvim_create_autocmd('VimResized', { group = augroup, command = 'wincmd =' })
