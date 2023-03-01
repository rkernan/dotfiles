return {
  'echasnovski/mini.nvim',
  event = 'VeryLazy',
  config = function ()
    require('mini.ai').setup()
    require('mini.align').setup()
    require('mini.bracketed').setup()
    require('mini.comment').setup()
    require('mini.move').setup()
    require('mini.surround').setup()
    require('mini.trailspace').setup()
  end,
}
