return {
  'folke/todo-comments.nvim',
  event = 'ColorScheme',
  opts = {
    highlight = {
      multiline = false,
      keyword = 'bg',
      pattern = [[.*<(KEYWORDS)\s*]],
    },
    search = {
      pattern = [[\b(KEYWORDS)]],
    },
  },
}
