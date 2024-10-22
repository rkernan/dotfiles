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
end

return { setup = setup }
