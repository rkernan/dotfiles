return {
  'rebelot/heirline.nvim',
  event = 'ColorScheme',
  config = function ()
    require('heirline').setup({
      statusline = require('user.plugins.heirline.statusline'),
      winbar = require('user.plugins.heirline.winbar'),
      -- tabline = {},
      -- statuscolumn = {},
    })
  end
}
