return {
  'mhartington/formatter.nvim',
  event = 'VeryLazy',
  config = function ()
    require("formatter").setup({
      logging = true,
      log_level = vim.log.levels.WARN,
      filetype = {
        python = {
          require('formatter.filetypes.python').isort,
        },
        ['*'] = {
          require('formatter.filetypes.any').remove_trailing_whitespace,
        },
      },
    })

    local augroup = vim.api.nvim_create_augroup('formatter', { clear = true })
    vim.api.nvim_create_autocmd('BufWritePost', { group = augroup, callback = function () vim.cmd('FormatWrite') end })
  end
}
