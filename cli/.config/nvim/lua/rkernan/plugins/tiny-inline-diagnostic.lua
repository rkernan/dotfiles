return {
  'rachartier/tiny-inline-diagnostic.nvim',
  event = 'VeryLazy',
  priority = 1000,
  opts = {
    preset = 'minimal',
    options = {
      enable_on_insert = true,
      show_all_diags_on_cursorline = true,
      format = function (diagnostic)
        local icon = require('rkernan.diagnostics').signs[diagnostic.severity]
        return string.format('%s %s [%s]', icon, diagnostic.message, diagnostic.source)
      end,
    },
  },
}
