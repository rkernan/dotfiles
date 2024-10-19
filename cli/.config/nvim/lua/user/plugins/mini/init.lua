local keys = require('user.plugins.mini.pick').keys
keys = table.insert(keys, {  '<Leader>F', function () require('mini.files').open() end, desc = 'File explorer' })

return {
  'echasnovski/mini.nvim',
  version = false,
  lazy = false,
  keys = require('user.plugins.mini.pick').keys,
  config = function()
    require('mini.ai').setup()
    require('mini.align').setup()
    require('mini.bracketed').setup()
    require('mini.comment').setup()
    require('mini.files').setup()
    require('mini.jump').setup()
    require('mini.jump2d').setup()
    require('mini.operators').setup()
    require('mini.pairs').setup()
    require('mini.surround').setup()
    require('mini.trailspace').setup()
    require('user.plugins.mini.basics').setup()
    require('user.plugins.mini.clue').setup()
    require('user.plugins.mini.icons').setup()
    require('user.plugins.mini.hlpatterns').setup()
    require('user.plugins.mini.move').setup()
    require('user.plugins.mini.pick').setup()
  end,
}
