local augroup = vim.api.nvim_create_augroup('rkernan.autocmds', { clear = true })

-- automatic insert mode in terms
vim.api.nvim_create_autocmd({ 'TermOpen', 'BufEnter' }, { group = augroup, pattern = 'term://*', command = [[startinsert]] })

-- resize windows automatically
vim.api.nvim_create_autocmd('VimResized', { group = augroup, command = [[wincmd =]] })

-- disable hlsearch on cursor move
vim.api.nvim_create_autocmd('CursorMoved', {
  group = augroup,
  callback = function ()
    if vim.v.hlsearch and vim.fn.searchcount().exact_match == 0 then
      vim.schedule(function ()
        vim.cmd.nohlsearch()
        vim.api.nvim_exec_autocmds('User', { pattern = 'HlSearchDisabled' })
      end
      )
    end
  end,
})

require('rkernan.git').setup_head()
require('rkernan.diagnostic').setup_auto_loclist()
require('rkernan.statusline').setup_colors()
require('rkernan.statusline').setup_redraw()
require('rkernan.statusline').setup_winbar()

require('mini.misc').setup_auto_root({ '.git', '.venv', '.editorconfig' })
require('mini.misc').setup_restore_cursor()
