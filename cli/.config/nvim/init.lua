-- disable distribution plugins
vim.g.loaded_gzip = true
vim.g.loaded_tar = true
vim.g.loaded_tarPlugin = true
vim.g.loaded_zip = true
vim.g.loaded_zipPlugin = true
vim.g.loaded_getscript = true
vim.g.loaded_getscriptPlugin = true
vim.g.loaded_vimball = true
vim.g.loaded_vimballPlugin = true
vim.g.loaded_matchit = true
vim.g.loaded_matchparen = true
vim.g.loaded_2html_plugin = true
vim.g.loaded_logiPat = true
vim.g.loaded_rrhelper = true
vim.g.loaded_netrw = true
vim.g.loaded_netrwPlugin = true
vim.g.loaded_netrwSettings = true
vim.g.loaded_netrwFileHandlers = true

-- space as leader
vim.g.mapleader = ' '
vim.keymap.set('n', ' ', '', { noremap = true })
vim.keymap.set('x', ' ', '', { noremap = true })

-------------
-- Options --
-------------

local cache_dir = vim.env.HOME .. '/.cache/nvim/'

vim.opt.termguicolors = true
vim.opt.hidden = true
vim.opt.magic = true
vim.opt.virtualedit = 'block'
vim.opt.clipboard = 'unnamedplus'
vim.opt.wildignorecase = true
vim.opt.swapfile = false
vim.opt.directory = cache_dir .. 'swap/'
vim.opt.undodir = cache_dir .. 'undo/'
vim.opt.backupdir = cache_dir .. 'backup/'
vim.opt.viewdir = cache_dir .. 'view/'
vim.opt.spellfile = cache_dir .. 'spell/en.uft-8.add'
vim.opt.history = 2000
vim.opt.timeout = true
vim.opt.ttimeout = true
vim.opt.timeoutlen = 500
vim.opt.ttimeoutlen = 10
vim.opt.updatetime = 100
vim.opt.redrawtime = 1500
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.infercase = true

if vim.fn.executable('rg') == 1 then
  vim.opt.grepformat = '%f:%l:%c:%m,%f:%l:%m'
  vim.opt.grepprg = 'rg --vimgrep --no-heading --smart-case'
end

vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.showmode = false
vim.opt.shortmess = 'aoOTIcF'
vim.opt.scrolloff = 2
vim.opt.sidescrolloff = 5
vim.opt.ruler = false
vim.opt.showtabline = 0
vim.opt.winwidth = 30
vim.opt.pumheight = 15
vim.opt.showcmd = false
vim.opt.cmdheight = 1
vim.opt.laststatus = 3
vim.opt.list = true
vim.opt.listchars = {
  eol = '¬',
  tab = '»·',
  nbsp = '+',
  trail = '·',
  extends = '→',
  precedes = '←',
}
vim.opt.fillchars = { eob = ' ' }
vim.opt.undofile = true

vim.opt.smarttab = true
vim.opt.expandtab = false
vim.opt.autoindent = true
vim.opt.tabstop = 8
vim.opt.shiftwidth = 8

vim.opt.signcolumn = 'yes'
vim.opt.spelloptions = 'camel'

vim.opt.splitbelow = true
vim.opt.splitright = true

--------------
-- Mappings --
--------------

-- disable ex mode mapping
vim.keymap.set('n', 'Q', function () end)

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

------------
-- Events --
------------
local augroup = vim.api.nvim_create_augroup('core', { clear = true })

-- jump to last position on start
vim.api.nvim_create_autocmd('BufReadPost', {
  group = group,
  callback = function ()
    local row, _ = unpack(vim.api.nvim_buf_get_mark(0, '"'))
    local max_row = vim.fn.line('$')
    vim.api.nvim_win_set_cursor(0, { row <= max_row and row or max_row, 0 })
  end
})

-- resize windows automatically
vim.api.nvim_create_autocmd('VimResized', { group = augroup, command = 'wincmd =' })

require('core.packer')
