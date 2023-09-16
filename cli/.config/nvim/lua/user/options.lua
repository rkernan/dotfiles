local cache_dir = vim.env.HOME .. '/.cache/nvim/'

vim.opt.termguicolors = true
vim.opt.virtualedit = 'block'
vim.opt.clipboard = 'unnamedplus'
vim.opt.wildignorecase = true
vim.opt.swapfile = false
vim.opt.directory = cache_dir .. 'swap/'
vim.opt.undodir = cache_dir .. 'undo/'
vim.opt.backupdir = cache_dir .. 'backup/'
vim.opt.viewdir = cache_dir .. 'view/'
vim.opt.history = 2000
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

vim.opt.completeopt = { 'menuone', 'noinsert', 'noselect' }
vim.opt.showmode = false
vim.opt.shortmess = 'aoOTIcF'
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5
vim.opt.ruler = false
vim.opt.showtabline = 0
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

vim.opt.spelloptions = 'camel'

vim.opt.splitbelow = true
vim.opt.splitright = true
