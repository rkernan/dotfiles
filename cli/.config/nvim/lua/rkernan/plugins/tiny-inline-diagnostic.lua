return {
  'rachartier/tiny-inline-diagnostic.nvim',
  event = 'VeryLazy',
  priority = 1000,
  opts = {
    preset = 'SIMPLE',
    options = {
      show_source = true,
      use_icons_from_diagnostic = true,
    },
  },
}
