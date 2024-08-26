local function setup()
  require('mini.basics').setup({
    options = {
      basic = true,
      extra_ui = true,
      win_borders = 'single',
    },
    mappings = {
      basic = false,
    },
    autocommands = {
      basic = false,
    },
  })
  -- additional listchars
  vim.o.showbreak = '⌙'
  vim.o.listchars = 'eol:¬,tab:»·,nbsp:␣,trail:·,extends:→,precedes:←'
  vim.o.list = false
  -- restore <C-z>
  vim.keymap.set('n', '<C-z>', '<Cmd>stop<CR>')
end

return { setup = setup }
