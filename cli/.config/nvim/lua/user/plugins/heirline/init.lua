return {
  'rebelot/heirline.nvim',
  event = 'ColorScheme',
  config = function ()
    local components = require('user.plugins.heirline.components')

    require('heirline').setup({
      statusline = {
        components.vi_mode,
        components.git.head,
        components.work_dir,
        components.align,
        -- components.noice.mode,
        -- components.noice.search,
        components.file.tabs,
        components.file.format,
        components.file.encoding,
      },
      winbar = {
        components.file.name,
        components.git.diff,
        components.navic,
        components.align,
        components.diagnostics,
        components.ruler,
      },
      -- tabline = {},
      -- statuscolumn = {},
    })
  end
}
