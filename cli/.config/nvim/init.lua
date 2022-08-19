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

-- see :h last-position-jump
vim.cmd([[autocmd BufRead * autocmd FileType <buffer> ++once if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif]])

utils.create_augroup({
  -- resize windows automatically
  { 'VimResized', '*', 'wincmd =' },
  -- cursorline and relative line numbers for active buffer
  { 'BufWinEnter,VimEnter,WinEnter', '*', ":lua require('utils').setlocal_no_float({ 'cursorline', 'relativenumber' })" },
  { 'WinLeave', '*', ":lua require('utils').setlocal_no_float({ 'nocursorline', 'norelativenumber' })" },
  -- no relative line numbers in insert mode
  { 'InsertEnter', '*', ":lua require('utils').setlocal_no_float({ 'norelativenumber' })" },
  { 'InsertLeave', '*', ":lua require('utils').setlocal_no_float({ 'relativenumber' })" }
}, 'vimrc')

require('tabs')
require('plugins')
