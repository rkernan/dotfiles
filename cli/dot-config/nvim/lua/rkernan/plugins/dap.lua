vim.pack.add({
  'https://github.com/igorlfs/nvim-dap-view.git',
  'https://github.com/mfussenegger/nvim-dap.git',
}, { confirm = false })
require('dap-view').setup({ winbar = { controls = { enabled = true } } })
