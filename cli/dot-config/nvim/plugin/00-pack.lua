local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_deps_path = path_package .. 'pack/deps/start/mini.deps'
if not vim.uv.fs_stat(mini_deps_path) then
  vim.cmd('echo "Installing `mini.deps`" | redraw')
  local clone_cmd = {
    'git', 'clone', '--filter=blob:none',
    'https://github.com/nvim-mini/mini.deps', mini_deps_path
  }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.deps | helptags ALL')
  vim.cmd('echo "Installed `mini.deps`" | redraw')
end

require('mini.deps').setup({ path = { package = path_package } })

---@diagnostic disable: undefined-global
local add = MiniDeps.add
---@diagnostic enable: undefined-global

add({ name = 'mini.deps', checkout = 'stable' })

add({ source = 'mfussenegger/nvim-lint' })
add({ source = 'mrjones2014/smart-splits.nvim' })
add({ source = 'neovim/nvim-lspconfig' })
add({ source = 'nmac427/guess-indent.nvim' })
add({ source = 'nvim-mini/mini.ai', checkout = 'stable' })
add({ source = 'nvim-mini/mini.align', checkout = 'stable' })
add({ source = 'nvim-mini/mini.bracketed', checkout = 'stable' })
add({ source = 'nvim-mini/mini.cmdline', checkout = 'stable' })
add({ source = 'nvim-mini/mini.comment', checkout = 'stable' })
add({ source = 'nvim-mini/mini.completion', checkout = 'stable' })
add({ source = 'nvim-mini/mini.diff', checkout = 'stable' })
add({ source = 'nvim-mini/mini.extra', checkout = 'stable' })
add({ source = 'nvim-mini/mini.hipatterns', checkout = 'stable' })
add({ source = 'nvim-mini/mini.icons', checkout = 'stable' })
add({ source = 'nvim-mini/mini.misc', checkout = 'stable' })
add({ source = 'nvim-mini/mini.notify', checkout = 'stable' })
add({ source = 'nvim-mini/mini.operators', checkout = 'stable' })
add({ source = 'nvim-mini/mini.pairs', checkout = 'stable' })
add({ source = 'nvim-mini/mini.pick', checkout = 'stable' })
add({ source = 'nvim-mini/mini.surround', checkout = 'stable' })
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
