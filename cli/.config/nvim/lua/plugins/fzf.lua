require('fzf-lua').setup({
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

vim.api.nvim_set_keymap('n', '<leader>b', "<cmd>FzfLua buffers<cr>", { noremap = true})
vim.api.nvim_set_keymap('n', '<leader>f', "<cmd>FzfLua files<cr>", { noremap = true})
vim.api.nvim_set_keymap('n', '<leader>/', "<cmd>FzfLua live_grep<cr>", { noremap = true})
