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
    if vim.wo.number then
      vim.schedule(function () vim.wo.relativenumber = true end)
    end
  end,
})

-- norelativenumber in inactive windows and insert mode
vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost', 'InsertEnter', 'WinLeave' }, {
  group = augroup,
  callback = function ()
    if vim.wo.number then
      vim.schedule(function () vim.wo.relativenumber = false end)
    end
  end,
})

-- disable hlsearch on cursor move
vim.api.nvim_create_autocmd('CursorMoved', {
  group = augroup,
  callback = function ()
    if vim.v.hlsearch and vim.fn.searchcount().exact_match == 0 then
      vim.schedule(function () vim.cmd.nohlsearch() end)
    end
  end,
})
