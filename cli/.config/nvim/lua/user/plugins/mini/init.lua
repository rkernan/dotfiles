return {
  'echasnovski/mini.nvim',
  lazy = false,
  keys = {
    { '<C-w>z', function () require('mini.misc').zoom() end, desc = 'Toggle zoom' },
  },
  config = function()
    require('mini.ai').setup()
    require('mini.align').setup()
    require('mini.bracketed').setup()
    require('mini.comment').setup()
    require('mini.extra').setup()
    require('mini.jump').setup()
    require('mini.jump2d').setup()
    require('mini.operators').setup()
    require('mini.pairs').setup()
    require('mini.surround').setup()
    require('mini.trailspace').setup()
    require('user.plugins.mini.basics').setup()
    require('user.plugins.mini.clue').setup()
    require('user.plugins.mini.hlpatterns').setup()
    require('user.plugins.mini.misc').setup()
    require('user.plugins.mini.move').setup()
  end,
}
