local utils = require('utils')

-- enable 24-bit colors
-- FIXME fix TERM
if utils.enable_unicode() then vim.o.termguicolors = true end
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

-- space as leader
vim.api.nvim_set_keymap('n', '<Space>', '', {})
vim.g.mapleader = ' '

-- disable ex mode
vim.api.nvim_set_keymap('n', 'Q', '<nop>', { noremap = true })

-- yank to end of line
vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true })

-- treat lines wraps as real lines
vim.api.nvim_set_keymap('n', 'j', 'gj', { noremap = true })
vim.api.nvim_set_keymap('n', 'k', 'gk', { noremap = true })
vim.api.nvim_set_keymap('n', 'gj', 'j', { noremap = true })
vim.api.nvim_set_keymap('n', 'gk', 'k', { noremap = true })

-- keep highlight after changing indent
vim.api.nvim_set_keymap('v', '>', '>gv', { noremap = true })
vim.api.nvim_set_keymap('v', '<', '<gv', { noremap = true })

-- automatically jump to the end of the last paste
vim.api.nvim_set_keymap('v', 'y', 'y`]', { noremap = true })
vim.api.nvim_set_keymap('v', 'p', 'p`]', { noremap = true })
vim.api.nvim_set_keymap('n', 'p', 'p`]', { noremap = true })

-- disable highlighting until the next search
vim.api.nvim_set_keymap('n', 'noh', ':noh<CR>', { noremap = true, nowait = true, silent = true })

local utils = require('utils')
utils.create_augroup({
  -- resize windows automatically
  { 'VimResized', '*', 'wincmd =' },
  -- auto-switch to/from relative line numbers based on mode and window focus
  { 'BufEnter,FocusGained,InsertEnter,WinEnter', '*', 'setlocal relativenumber cursorline'    },
  { 'BufLeave,FocusLost,InsertLeave,WinLeave',   '*', 'setlocal norelativenumber nocursorline'}
}, 'vimrc')

require('tabs')
require('plugins')
