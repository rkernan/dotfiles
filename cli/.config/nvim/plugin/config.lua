vim.g.loaded_netrw = true
vim.g.loaded_netrwPlugin = true

if vim.fn.has('wsl') > 0 then
  vim.g.clipboard = {
    name = 'WslClipboard',
    copy = {
      ['+'] = 'clip.exe',
      ['*'] = 'clip.exe',
    },
    paste = {
      ['+'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      ['*'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    },
    cache_enabled = false,
  }
end

if vim.fn.executable('rg') == 1 then
  vim.opt.grepformat = '%f:%l:%c:%m,%f:%l:%m'
  vim.opt.grepprg = 'rg --vimgrep --no-heading --smart-case'
end

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.undofile = true
vim.opt.mouse = 'a'
vim.cmd.filetype('plugin indent on')
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.ruler = false
vim.opt.showmode = false
vim.opt.wrap = false
vim.opt.fillchars = {
  eob = ' ',
  foldopen = '',
  foldclose = '',
  foldsep = ' ',
}
vim.opt.ignorecase = true
vim.opt.infercase = true
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.completeopt = 'menuone,noselect'
vim.opt.shortmess = vim.opt.shortmess:append('IWcC')
vim.opt.scrolloff = 5
vim.opt.pumblend = 10
vim.opt.pumheight = 10
vim.opt.winblend = 10
vim.opt.listchars = {
  eol = '¬',
  tab = '»·',
  nbsp = '␣',
  trail = '·',
  extends = '→',
  precedes = '←',
}
vim.opt.showbreak = '⌙'
vim.opt.list = false
vim.cmd('syntax enable')
vim.cmd('colorscheme gruvbones')

-- fix for tmux terms
if os.getenv('TERM'):find('-256color') then
  vim.opt.termguicolors = true
end

vim.notify = require('mini.notify').make_notify({ INFO = { hl_group = 'MiniNotifyNormal' }})

---@diagnostic disable: duplicate-set-field
vim.ui.select = function (...) return require('mini.pick').ui_select(...) end
---@diagnostic enable: duplicate-set-field
