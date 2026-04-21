vim.pack.add({
  'https://github.com/igorlfs/nvim-dap-view.git',
  'https://github.com/mfussenegger/nvim-dap.git',
})
require('dap-view').setup({ winbar = { controls = { enabled = true } } })
