return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  ---@module "conform"
  ---@type conform.setupOpts
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
  },
}
