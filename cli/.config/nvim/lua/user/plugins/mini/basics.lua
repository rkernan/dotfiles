local function setup()
  require('mini.basics').setup({
    options = {
      extra_ui = true,
      win_borders = 'single',
    },
    mappings = {
      move_with_alt = true,
    },
    autocommands = {
      basic = false,
    },
  })
  -- additional listchars
  vim.o.showbreak = '⌙'
  vim.o.listchars = 'eol:¬,tab:»·,nbsp:␣,trail:·,extends:→,precedes:←'
  -- restore <C-z>
  vim.keymap.set('n', '<C-z>', '<Cmd>stop<CR>')
end

return { setup = setup }
