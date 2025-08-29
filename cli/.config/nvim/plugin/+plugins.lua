local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'
if not vim.uv.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = {
    'git', 'clone', '--filter=blob:none',
    'https://github.com/nvim-mini/mini.nvim', mini_path
  }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.nvim | helptags ALL')
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

require('mini.deps').setup({ path = { package = path_package } })

---@diagnostic disable: undefined-global
local add = MiniDeps.add
---@diagnostic enable: undefined-global

require('rkernan.plugins.mini')
require('rkernan.plugins.blink-cmp')
require('rkernan.plugins.conform')
require('rkernan.plugins.faster')
require('rkernan.plugins.guess-indent')
require('rkernan.plugins.lint')
require('rkernan.plugins.treesitter')
require('rkernan.plugins.gruvbones')
pcall(require, 'rkernan.plugins.tabnine')
add({ source = 'neovim/nvim-lspconfig' })
