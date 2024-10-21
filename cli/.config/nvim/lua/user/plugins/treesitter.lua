return {
  'nvim-treesitter/nvim-treesitter',
  event = { 'BufNewFile', 'BufReadPost' },
  build = ':TSUpdate',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    'RRethy/nvim-treesitter-endwise',
  },
  config = function ()
    require('nvim-treesitter.configs').setup({
      auto_install = true,
      highlight = { enable = true },
      incremental_selection = { enable = true },
      indent = { enable = true },
      endwise = { enable = true },
    })
  end,
}
