return {
  'ThePrimeagen/refactoring.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-telescope/telescope.nvim',
  },
  keys = {
    { '<leader>rr', function () require('telescope').extensions.refactoring.refactors() end, mode = 'x', desc = 'Refactoring' },
  },
  config = function ()
    require('refactoring').setup()
    require('telescope').load_extension('refactoring')
  end
}
