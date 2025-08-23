---@diagnostic disable: undefined-global
local add = MiniDeps.add
---@diagnostic enable: undefined-global

add({ source = 'stevearc/conform.nvim' })
require('conform').setup({
  formatters_by_ft = {
    ['*'] = { 'trim_whitespace' },
  },
  format_on_save = { timeout_ms = 500 }
})
