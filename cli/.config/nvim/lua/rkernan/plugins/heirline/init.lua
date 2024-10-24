local buftype_disable = { 'nofile', 'help', 'prompt', 'quickfix', 'terminal' }
local filetype_disable = { 'minipick', }

return {
  'rebelot/heirline.nvim',
  lazy = false,
  config = function ()
    require('heirline').setup({
      statuscolumn = require('rkernan.plugins.heirline.statuscolumn'),
      statusline = require('rkernan.plugins.heirline.statusline'),
      winbar = require('rkernan.plugins.heirline.winbar'),
      opts = {
        disable_winbar_cb = function ()
          return require('heirline.conditions').buffer_matches({
            buftype = buftype_disable,
            filetype = filetype_disable,
          })
        end
      },
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
