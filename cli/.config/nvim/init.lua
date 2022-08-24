local utils = require('utils')

-- enable 24-bit colors
vim.o.termguicolors = true
-- enable undo file
vim.o.undofile = true
-- ignorecase unless pattern contains uppercase letters
vim.o.ignorecase = true
vim.o.smartcase = true
-- unicode hidden characters
if utils.enable_unicode() then vim.o.listchars = 'eol:¬,tab:» ,trail:·' end
-- always show completion, don't select by default
vim.o.completeopt = 'menu,menuone,noselect'
-- complete longest common string, then list alternatives
vim.o.wildmode = 'longest:full,full'
-- keep 1 line above and below cursor on screen
vim.o.scrolloff = 1
-- don't redraw scren while executing macros
vim.o.lazyredraw = true
-- split next window below current
vim.o.splitbelow = true
-- vsplit next window right of current
vim.o.splitright = true
-- make vim quieter
vim.o.shortmess = 'actWIFS'
-- show line numbers
vim.o.number = true
-- don't print mode in cmd area
vim.o.showmode = false
-- enable mouse
vim.o.mouse = 'a'
-- set window title
vim.o.title = true
-- always copy to system clipboard
vim.o.clipboard = vim.o.clipboard .. 'unnamedplus'
-- timeout maps faster
vim.o.timeoutlen = 500

-- space as leader
vim.g.mapleader = ' '

-- disable ex mode
vim.keymap.set('n', 'Q', '<nop>')

-- yank to end of line
vim.keymap.set('n', 'Y', 'y$')

-- treat lines wraps as real lines
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')
vim.keymap.set('n', 'gj', 'j')
vim.keymap.set('n', 'gk', 'k')

-- keep highlight after changing indent
vim.keymap.set('v', '>', '>gv')
vim.keymap.set('v', '<', '<gv')

-- automatically jump to the end of the last paste
vim.keymap.set('v', 'y', 'y`]')
vim.keymap.set({ 'n', 'v' }, 'p', 'p`]')

local group = vim.api.nvim_create_augroup('vimrc', {})
-- jump to last-position on start, replaces last-position-jump
vim.api.nvim_create_autocmd('BufReadPost', { group = group,
  callback = function ()
    local row, _ = unpack(vim.api.nvim_buf_get_mark(0, '"'))
    local max_row = vim.fn.line('$')
    vim.api.nvim_win_set_cursor(0, { row <= max_row and row or max_row, 0 })
  end
})
-- resize windows automatically
vim.api.nvim_create_autocmd('VimResized', { group = group, pattern = '*', command = 'wincmd =' })
-- cursorline and relative line numbers of active buffers
vim.api.nvim_create_autocmd({ 'BufWinEnter', 'VimEnter', 'WinEnter' }, { group = group, pattern = '*',
  callback = function () utils.setlocal_no_float({ 'cursorline', 'relativenumber' }) end })
vim.api.nvim_create_autocmd('WinLeave', { group = group, pattern = '*',
  callback = function () utils.setlocal_no_float({ 'nocursorline', 'norelativenumber' }) end })
-- no relative line numbers in insert mode
vim.api.nvim_create_autocmd('InsertEnter', { group = group, pattern = '*',
  callback = function () utils.setlocal_no_float({ 'norelativenumber' }) end })
vim.api.nvim_create_autocmd('InsertLeave', { group = group, pattern = '*',
  callback = function () utils.setlocal_no_float({ 'relativenumber' }) end })

require('tabs')
require('plugins')
