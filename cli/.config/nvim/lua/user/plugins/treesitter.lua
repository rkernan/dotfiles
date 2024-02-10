return {
  'nvim-treesitter/nvim-treesitter',
  event = { 'BufNew', 'BufRead' },
  build = ':TSUpdate',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    'RRethy/nvim-treesitter-endwise',
  },
  config = function ()
    require('nvim-treesitter.configs').setup({
      ensure_installed = 'all',
      highlight = { enable = true },
      indent = { enable = true },
      endwise = { enable = true },
    })
  end,
}
