local augroup = vim.api.nvim_create_augroup('rkernan.autocmds', { clear = true })

-- highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function ()
    (vim.hl or vim.highlight).on_yank()
  end,
  group = augroup,
})

-- auto create dir when saving
vim.api.nvim_create_autocmd('BufWritePre', {
  callback = function (event)
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
  end,
  group = augroup,
})

-- automatic insert mode in terminals
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

-- auto-open quickfix
vim.api.nvim_create_autocmd('QuickFixCmdPost', {
  group = augroup,
  pattern = '[^l]*',
  callback = function () vim.cmd.cwindow() end
})

-- auto-open loclist
vim.api.nvim_create_autocmd('QuickFixCmdPost', {
  group = augroup,
  pattern = 'l*',
  callback = function () vim.cmd.lwindow() end,
})

require('rkernan.git').setup_head()
require('rkernan.diagnostic').setup_auto_loclist()

local statusline = require('rkernan.statusline')
statusline.setup_colors()
statusline.setup_redraw()
statusline.setup_winbar()

local mini_misc = require('mini.misc')
mini_misc.setup_auto_root({ '.git', '.venv', '.editorconfig' })
mini_misc.setup_restore_cursor()
