return {
  'mfussenegger/nvim-dap',
  event = 'VeryLazy',
  dependencies = {
    -- telescope UI
    'nvim-telescope/telescope.nvim',
    'nvim-telescope/telescope-dap.nvim',
    -- languages
    'mfussenegger/nvim-dap-python',
  },
  keys = require('user.plugins.dap.clues').gen_keys(),
  config = function ()
    require('telescope').load_extension('dap')
    vim.fn.sign_define('DapBreakpoint', { text = ' ', texthl = '', linehl = '', numhl = '' })
    require('dap-python').setup()
  end
}
