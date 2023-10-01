return {
  'kevinhwang91/nvim-ufo',
  dependencies = {
    'kevinhwang91/promise-async'
  },
  event = 'VeryLazy',
  keys = {
    { 'zR', function () require('ufo').openAllFolds() end, desc = 'Open all folds' },
    { 'zM', function () require('ufo').closeAllFolds() end, desc = 'Open all folds' },
  },
  config = function ()
    vim.o.foldcolumn = '1'
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
    vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

    require('ufo').setup({
      provider_selector = function ()
        return { 'treesitter', 'indent' }
      end,
    })
  end
}
