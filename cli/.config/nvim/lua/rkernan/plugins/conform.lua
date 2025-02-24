return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  opts = {
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
  },
}
