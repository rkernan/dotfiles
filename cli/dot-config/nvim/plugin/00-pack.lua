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

add({ name = 'mini.nvim', checkout = 'stable' })
add({ source = 'mfussenegger/nvim-lint' })
add({ source = 'mrjones2014/smart-splits.nvim' })
add({ source = 'neovim/nvim-lspconfig' })
add({ source = 'nmac427/guess-indent.nvim' })
add({ source = 'nvim-treesitter/nvim-treesitter' })
add({ source = 'pteroctopus/faster.nvim' })
add({ source = 'stevearc/conform.nvim' })
add({ source = 'stevearc/oil.nvim' })
add({ source = 'yorickpeterse/nvim-pqf' })

require('guess-indent').setup()
require('faster').setup()
require('oil').setup()

require('rkernan.plugins.mini')
require('rkernan.plugins.conform')
require('rkernan.plugins.lint')
require('rkernan.plugins.pqf')
require('rkernan.plugins.treesitter')
require('rkernan.plugins.gruvbones')

pcall(require, 'rkernan.plugins.tabnine')
