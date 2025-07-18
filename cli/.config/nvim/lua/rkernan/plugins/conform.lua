---@diagnostic disable: undefined-global
local add, later = MiniDeps.add, MiniDeps.later
---@diagnostic enable: undefined-global

later(function ()
  add({ source = 'stevearc/conform.nvim' })
  require('conform').setup({
    formatters_by_ft = {
      go = {
        'goimports',
        'gofmt',
      },
      python = {
        'isort',
        -- 'black',
      },
      ['*'] = {
        'trim_whitespace',
      },
    },
    format_on_save = {
      timeout_ms = 500,
    },
    formatters = {
      isort = {
        prepend_args = { '--profile', 'black' }
      }
    }
  })
end)
