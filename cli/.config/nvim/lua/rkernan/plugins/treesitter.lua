---@diagnostic disable: undefined-global
local add, now = MiniDeps.add, MiniDeps.now
---@diagnostic enable: undefined-global

add({ source = 'nvim-treesitter/nvim-treesitter' })
add({ source = 'nvim-treesitter/nvim-treesitter-textobjects', depends = { 'nvim-treesitter/nvim-treesitter' } })
add({ source = 'RRethy/nvim-treesitter-endwise', depends = { 'nvim-treesitter/nvim-treesitter' } })
now(function ()
  require('nvim-treesitter.configs').setup({
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
    endwise = { enable = true },
    additional_vim_regex_highlighting = false,
  })
end)
