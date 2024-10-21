return {
  'rebelot/heirline.nvim',
  lazy = false,
  config = function ()
    require('heirline').setup({
      statuscolumn = require('rkernan.plugins.heirline.statuscolumn'),
      statusline = require('rkernan.plugins.heirline.statusline'),
      winbar = require('rkernan.plugins.heirline.winbar'),
    })

    local augroup = vim.api.nvim_create_augroup('rkernan.plugins.heirline', { clear = true })
    vim.api.nvim_create_autocmd('ColorScheme', {
      callback = function ()
        require('heirline.utils').on_colorscheme(require('rkernan.plugins.heirline.colors').setup_colors())
      end,
      group = augroup,
    })
  end
}
