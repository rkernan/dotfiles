return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'theHamsta/nvim-dap-virtual-text',
    'mfussenegger/nvim-dap-python',
  },
  keys = require('user.plugins.dap.keys').gen_keys(),
  config = function ()
    vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DiagnosticSignWarn', linehl = '', numhl = '' })
    require("nvim-dap-virtual-text").setup()
    require('dap-python').setup()
  end
}
