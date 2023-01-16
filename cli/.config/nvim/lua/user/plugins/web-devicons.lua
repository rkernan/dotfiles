return {
  'kyazdani42/nvim-web-devicons',
  event = 'VeryLazy',
  config = function ()
    require('nvim-web-devicons').setup({ color_icons = false })
  end,
}
