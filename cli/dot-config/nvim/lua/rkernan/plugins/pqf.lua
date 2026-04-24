return {
  src = 'https://github.com/yorickpeterse/nvim-pqf.git',
  data = {
    when = 'event:QuickFixCmdPre',
    config = function()
      local signs = require('rkernan.diagnostic').signs
      require('pqf').setup({
        signs = {
          error = { text = signs[vim.diagnostic.severity.ERROR] },
          warning = { text = signs[vim.diagnostic.severity.WARN] },
          info = { text = signs[vim.diagnostic.severity.INFO] },
          hint = { text = signs[vim.diagnostic.severity.HINT] },
        },
      })
    end,
  },
}
