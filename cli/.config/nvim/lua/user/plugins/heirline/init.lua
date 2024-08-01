return {
  'rebelot/heirline.nvim',
  lazy = false,
  config = function ()
    require('heirline').setup({
      -- statuscolumn = require('user.plugins.heirline.statuscolumn'),
      statusline = require('user.plugins.heirline.statusline'),
      winbar = require('user.plugins.heirline.winbar'),
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
