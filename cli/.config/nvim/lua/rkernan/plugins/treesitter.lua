---@diagnostic disable: undefined-global
local add = MiniDeps.add
---@diagnostic enable: undefined-global

add({ source = 'nvim-treesitter/nvim-treesitter' })
add({ source = 'nvim-treesitter/nvim-treesitter-textobjects', depends = { 'nvim-treesitter/nvim-treesitter' } })
require('nvim-treesitter.configs').setup({
  auto_install = true,
  highlight = { enable = true },
  indent = { enable = true },
  additional_vim_regex_highlighting = false,
})
