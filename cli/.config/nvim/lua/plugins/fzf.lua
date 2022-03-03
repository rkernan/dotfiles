local actions = require('fzf-lua.actions')
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
      ['default'] = actions.file_edit
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

local opts = { noremap = true }
vim.api.nvim_set_keymap('n', '<leader>b', "<cmd>lua require('fzf-lua').buffers()<CR>", opts)
vim.api.nvim_set_keymap('n', '<leader>f', "<cmd>lua require('fzf-lua').files()<CR>", opts)
vim.api.nvim_set_keymap('n', '<leader>/', "<cmd>lua require('fzf-lua').live_grep()<CR>", opts)
