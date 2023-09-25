return {
  'echasnovski/mini.nvim',
  event = 'VeryLazy',
  config = function ()
    require('mini.ai').setup()
    require('mini.align').setup()
    require('mini.bracketed').setup()
    require('mini.comment').setup()
    require('user.plugins.mini.clue').setup()
    require('mini.jump').setup()
    require('mini.jump2d').setup()
    require('user.plugins.mini.hlpatterns').setup()
    require('mini.move').setup()
    require('mini.pairs').setup()
    require('mini.surround').setup()
    require('mini.trailspace').setup()
  end,
}
