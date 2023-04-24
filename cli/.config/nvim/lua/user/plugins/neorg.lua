return {
  'nvim-neorg/neorg',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  event = 'VeryLazy',
  build = ':Neorg sync-parsers',
  opts = {
    load = {
      -- default behavior
      ['core.defaults'] = {},
      -- pretty icons
      ['core.concealer'] = {
        config = {
          icon_preset = 'varied',
        },
      },
      -- manage neorg workspaces
      ['core.dirman'] = {
        config = {
          workspaces = {
            notes = '~/Workspace/notes',
          },
          default_workspace = 'notes',
        },
      },
      -- completion using nvim-cmp
      ['core.completion'] = {
        config = {
          engine = 'nvim-cmp',
        },
      },
    },
  },
}
