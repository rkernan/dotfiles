---@diagnostic disable: undefined-global
local add, now = MiniDeps.add, MiniDeps.now
---@diagnostic enable: undefined-global

add({ source = 'rebelot/heirline.nvim' })
now(function ()
  require('heirline').setup({
    statuscolumn = require('rkernan.heirline.statuscolumn'),
    statusline = require('rkernan.heirline.statusline'),
    winbar = require('rkernan.heirline.winbar'),
    opts = {
      disable_winbar_cb = function ()
        return require('heirline.conditions').buffer_matches({
          buftype = { 'nofile', 'help', 'prompt', 'quickfix', 'terminal' },
          filetype = {},
        })
      end,
      colors = require('rkernan.heirline.colors').setup_colors(),
    },
  })

  local augroup = vim.api.nvim_create_augroup('rkernan.heirline', { clear = true })
  vim.api.nvim_create_autocmd('ColorScheme', {
    callback = function ()
      require('heirline.utils').on_colorscheme(require('rkernan.heirline.colors').setup_colors())
    end,
    group = augroup,
  })
end)
