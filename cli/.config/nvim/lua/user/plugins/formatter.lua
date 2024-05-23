return {
  'mhartington/formatter.nvim',
  cmd = { 'Format', 'FormatLock', 'FormatWrite', 'FormatWriteLock' },
  init = function ()
    local augroup = vim.api.nvim_create_augroup('formatter', { clear = true })
    vim.api.nvim_create_autocmd('BufWritePost', { group = augroup, callback = function () vim.cmd('FormatWrite') end })
  end,
  config = function ()
    require("formatter").setup({
      logging = true,
      log_level = vim.log.levels.WARN,
      filetype = {
        go = {
          require('formatter.filetypes.go').gofmt,
          require('formatter.filetypes.go').goimports,
        },
        python = {
          require('formatter.filetypes.python').isort,
          -- require('formatter.filetypes.python').black,
        },
        ['*'] = {
          require('formatter.filetypes.any').remove_trailing_whitespace,
        },
      },
    })
  end
}
