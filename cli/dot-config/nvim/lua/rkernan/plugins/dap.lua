return {
  {
    src = 'https://github.com/mfussenegger/nvim-dap.git',
    name = 'dap',
    data = {
      when = 'later',
    },
  },
  {
    src = 'https://github.com/igorlfs/nvim-dap-view.git',
    name = 'dap-view',
    data = {
      when = 'later',
      config = {
        winbar = {
          controls = {
            enabled = true,
          },
        },
      },
    },
  },
}
