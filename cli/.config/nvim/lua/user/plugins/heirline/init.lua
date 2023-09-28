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

    vim.api.nvim_create_augroup('plugins.heirline', { clear = true })
    vim.api.nvim_create_autocmd('ColorScheme', {
      callback = function ()
        require('heirline.utils').on_colorscheme(require('user.plugins.heirline.colors').setup_colors())
      end,
      group = 'plugins.heirline',
    })
  end
}
