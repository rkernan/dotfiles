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
      ['core.norg.concealer'] = {
        config = {
          icon_preset = 'varied',
        },
      },
      -- manage neorg workspaces
      ['core.norg.dirman'] = {
        config = {
          workspaces = {
            notes = '~/Workspace/notes',
          },
          default_workspace = 'notes',
        },
      },
      -- completion using nvim-cmp
      ['core.norg.completion'] = {
        config = {
          engine = 'nvim-cmp',
        },
      },
    },
  },
}
