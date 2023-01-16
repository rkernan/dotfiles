return {
  'nvim-treesitter/nvim-treesitter',
  event = { 'BufNew', 'BufRead' },
  build = ':TSUpdate',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    'RRethy/nvim-treesitter-endwise',
    'windwp/nvim-ts-autotag',
  },
  config = function ()
    require('nvim-ts-autotag').setup()
    require('nvim-treesitter.configs').setup({
      ensure_installed = 'all',
      highlight = { enable = true },
      endwise = { enable = true },
    })
  end,
}
