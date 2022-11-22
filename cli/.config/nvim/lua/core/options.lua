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
vim.opt.pumblend = 10
vim.opt.winblend = 10
vim.opt.undofile = true

vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- wrap
vim.opt.linebreak = true
vim.opt.whichwrap = 'h,l,<,>,[,],~'
vim.opt.breakindentopt = 'shift:2,min:20'
vim.opt.showbreak = '↳ '
vim.opt.foldlevelstart = 99
vim.opt.foldmethod = 'marker'

vim.opt.number = true
vim.opt.signcolumn = 'yes'
vim.opt.spelloptions = 'camel'

vim.opt.textwidth = 100
vim.opt.colorcolumn = '100'

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.cmd([[set background=dark]])
vim.cmd([[colorscheme gruvbones]])
