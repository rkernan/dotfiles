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
      cmdline = {
        view = 'cmdline',
        format = {
          cmdline = { icon = '>' },
          help = { icon = '?' },
          help_vert = { pattern = '^:vert %s*he?l?p?%s+', icon = '?' },
        }
      },
      messages = {
        view_history = 'popup',
        view_search = 'notify',
      },
      popupmenu = {
        enabled = false,
      },
      lsp = {
        progress = {
          format_done = '',
        },
        -- override markdown rendering so that cmp and other plugins user treesitter
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },
      format = {
        level = {
          icons = {
            error = '',
            warn = '',
            info = '',
          },
        },
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
