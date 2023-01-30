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
  keys = {
    { '<leader>dc', function () require('telescope').extensions.dap.commands() end, desc = 'DAP commands' },
    { '<leader>dC', function () require('telescope').extensions.dap.configurations() end, desc = 'DAP configs' },
    { '<leader>db', function () require('telescope').extensions.dap.list_breakpoints() end, desc = 'DAP breakpoints' },
    { '<leader>dv', function () require('telescope').extensions.dap.variables() end, desc = 'DAP variables' },
    { '<leader>df', function () require('telescope').extensions.dap.frames() end, desc = 'DAP frames' },
  },
  config = function ()
    require('telescope').load_extension('dap')
  end
}
