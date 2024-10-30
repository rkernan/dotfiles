return {
  'lewis6991/gitsigns.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  event = { 'BufNewFile', 'BufReadPost' },
  config = function ()
    require('gitsigns').setup({
      signs = {
        changedelete = { text = '┃' },
        untracked = { text = '┃' },
      },
      signs_staged = {
        changedelete = { text = '┃' },
        untracked = { text = '┃' },
      },
    })
  end,
}
