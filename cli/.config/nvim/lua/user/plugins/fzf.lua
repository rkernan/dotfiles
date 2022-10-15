local fzf = require('fzf-lua')

fzf.setup({
  winopts = {
    border = 'single',
    preview = {
      title = false,
      scrollbar = false
    }
  },
  files = {
    file_icons = false,
    actions = {
      ['default'] = require('fzf-lua.actions').file_edit
    }
  },
  git = {
    files = {
      file_icons = false,
    },
    status = {
      file_icons = false,
    },
  },
  grep = {
    file_icons = false,
  },
  buffers = {
    file_icons = false,
  },
  tabs = {
    file_icons = false,
  },
  tags = {
    file_icons = false,
  },
  btags = {
    file_icons = false,
  },
  quickfix = {
    file_icons = false,
  },
  lsp = {
    file_icons = false,
  },
  diagnostics = {
    file_icons = false,
    icon_padding = ' ',
  },
})

vim.keymap.set('n', '<leader>b', fzf.buffers)
vim.keymap.set('n', '<leader>f', fzf.files)
vim.keymap.set('n', '<leader>/', fzf.live_grep)
