require('nvim-ts-autotag').setup()
require('nvim-treesitter.configs').setup({
  ensure_installed = 'all',
  highlight = { enable = true },
  endwise = { enable = true },
})
