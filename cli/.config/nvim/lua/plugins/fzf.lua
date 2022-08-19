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
    actions = {
      ['default'] = require('fzf-lua.actions').file_edit
    }
  },
  lsp = {
    icons = {
      ["Error"] = { icon = "E", color = "red" },
      ["Warning"] = { icon = "W", color = "yellow" },
      ["Information"] = { icon = "I", color = "blue" },
      ["Hint"] = { icon = "H", color = "magenta" }
    },
  }
})

vim.keymap.set('n', '<leader>b', fzf.buffers)
vim.keymap.set('n', '<leader>f', fzf.files)
vim.keymap.set('n', '<leader>/', fzf.live_grep)
