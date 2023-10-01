return {
  'mfussenegger/nvim-dap',
  dependencies = {
    -- telescope UI
    'nvim-telescope/telescope.nvim',
    'nvim-telescope/telescope-dap.nvim',
    -- languages
    'mfussenegger/nvim-dap-python',
  },
  keys = require('user.plugins.dap.keys').gen_keys(),
  config = function ()
    require('telescope').load_extension('dap')
    vim.fn.sign_define('DapBreakpoint', { text = '󰜴', texthl = 'DiagnosticSignWarn', linehl = '', numhl = '' })
    require('dap-python').setup()
  end
}
