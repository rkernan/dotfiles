return {
  'folke/noice.nvim',
  dependencies = {
    'MunifTanjim/nui.nvim',
    'nvim-telescope/telescope.nvim',
  },
  event = 'VeryLazy',
  config = function ()
    require('telescope').load_extension('noice')
    require("noice").setup({
      lsp = {
        progress = {
          enabled = false,
        },
        -- override markdown rendering so that cmp and other plugins user treesitter
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },
      messages = {
        view_history = 'popup',
      },
      cmdline = {
        view = 'cmdline',
        format = {
          help_vert = { pattern = '^:vert %s*he?l?p?%s+', icon = '' },
        }
      },
      format = {
        search_down = {
          view = 'cmdline',
        },
        search_up = {
          view = 'cmdline',
        }
      },
      views = {
        popup = {
          border = {
            style = 'single',
          },
        },
      },
    })
  end,
}
