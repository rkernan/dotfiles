return {
  'nvim-treesitter/nvim-treesitter',
  event = { 'BufNew', 'BufRead' },
  build = ':TSUpdate',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  config = function ()
    require('nvim-treesitter.configs').setup({
      ensure_installed = 'all',
      highlight = { enable = true },
    })
  end,
}
