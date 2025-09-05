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

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.undofile = true
vim.opt.mouse = 'a'
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
vim.opt.foldcolumn = 'auto:1'
vim.opt.foldmethod = 'expr'
vim.opt.foldlevel = 99
vim.opt.ignorecase = true
vim.opt.infercase = true
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.completeopt = 'menuone,noselect'
vim.opt.shortmess = vim.opt.shortmess:append('aIcC')
vim.opt.showcmd = false
vim.opt.scrolloff = 5
vim.opt.pumblend = 10
vim.opt.pumheight = 10
vim.opt.winblend = 10
vim.opt.winborder = 'single'
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

vim.cmd.filetype('plugin indent on')

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

require('rkernan.statusline')
vim.opt.laststatus = 3
vim.opt.statusline = '%!v:lua.MyStatusline()'
vim.opt.signcolumn = 'yes'
vim.opt.statuscolumn = '%!v:lua.MyStatusColumn()'
vim.opt.tabline = '%!v:lua.MyTabLine()'

vim.api.nvim_create_user_command('SummarizeTabs', function () require('rkernan.set-tabs').summarize_tabs() end, { desc = 'Summarize current buffer tabs', nargs = 0 })
vim.api.nvim_create_user_command('SetTabs', function ()
  local set_tabs = require('rkernan.set-tabs')
  set_tabs.set_tabs()
  set_tabs.summarize_tabs()
end, { desc = 'Set current buffer tabs', nargs = 0 })
