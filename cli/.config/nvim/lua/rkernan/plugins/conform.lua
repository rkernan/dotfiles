local add, later = MiniDeps.add, MiniDeps.later

add({ source = 'stevearc/conform.nvim' })
later(function ()
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
