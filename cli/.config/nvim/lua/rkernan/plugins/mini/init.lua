local keys = require('rkernan.plugins.mini.pick').keys
keys = table.insert(keys, {  '<Leader>F', function () require('mini.files').open() end, desc = 'File explorer' })

return {
  'echasnovski/mini.nvim',
  version = false,
  lazy = false,
  keys = require('rkernan.plugins.mini.pick').keys,
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
    require('rkernan.plugins.mini.basics').setup()
    require('rkernan.plugins.mini.clue').setup()
    require('rkernan.plugins.mini.icons').setup()
    require('rkernan.plugins.mini.hlpatterns').setup()
    require('rkernan.plugins.mini.move').setup()
    require('rkernan.plugins.mini.pick').setup()
  end,
}
