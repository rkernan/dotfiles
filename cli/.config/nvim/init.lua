-- enable 24-bit colors
vim.opt.termguicolors = true
-- enable undo file
vim.opt.undofile = true
-- ignorecase unless pattern contains uppercase letters
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- unicode hidden characters
vim.opt.listchars = { eol = '¬', tab = '» ', trail = '·' }
-- don't show sign on empty lines
vim.opt.fillchars = { eob = ' ' }
-- always show completion, don't select by default
vim.opt.completeopt = { 'menu', 'menuone' , 'noselect' }
-- complete longest common string, then list alternatives
vim.opt.wildmode = { 'longest:full', 'full' }
-- keep 1 line above and below cursor on screen
vim.opt.scrolloff = 1
-- don't redraw scren while executing macros
vim.opt.lazyredraw = true
-- split next window below current
vim.opt.splitbelow = true
-- vsplit next window right of current
vim.opt.splitright = true
-- make vim quieter
vim.opt.shortmess = 'actWIFS'
-- don't print mode in cmd area
vim.opt.showmode = false
-- enable mouse
vim.opt.mouse = 'a'
-- set window title
vim.opt.title = true
-- always copy to system clipboard
vim.opt.clipboard = vim.o.clipboard .. 'unnamedplus'
-- timeout maps faster
vim.opt.timeoutlen = 500
-- trigger CursorHold faster
vim.opt.updatetime = 250

-- space as leader
vim.g.mapleader = ' '

-- disable ex mode
vim.keymap.set('n', 'Q', '<nop>')

-- yank to end of line
vim.keymap.set('n', 'Y', 'y$')

-- treat lines wraps as real lines
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')
vim.keymap.set('n', 'gj', 'j', { desc = 'Next line' })
vim.keymap.set('n', 'gk', 'k', { desc = 'Prev line' })

-- keep highlight after changing indent
vim.keymap.set('v', '>', '>gv')
vim.keymap.set('v', '<', '<gv')

-- automatically jump to the end of the last paste
vim.keymap.set('v', 'y', 'y`]')
vim.keymap.set({ 'n', 'v' }, 'p', 'p`]')

local group = vim.api.nvim_create_augroup('vimrc', { clear = true })
-- jump to last-position on start, replaces last-position-jump
vim.api.nvim_create_autocmd('BufReadPost', {
  group = group,
  callback = function ()
    local row, _ = unpack(vim.api.nvim_buf_get_mark(0, '"'))
    local max_row = vim.fn.line('$')
    vim.api.nvim_win_set_cursor(0, { row <= max_row and row or max_row, 0 })
  end
})
-- resize windows automatically
vim.api.nvim_create_autocmd('VimResized', { group = group, command = 'wincmd =' })

require('user.tabs')
require('user.numbers')
require('user.plugins')
require('user.terminal')

vim.cmd([[set background=dark]])
vim.cmd([[colorscheme gruvbones]])
