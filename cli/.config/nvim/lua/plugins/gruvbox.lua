local palette = require('gruvbox.palette')

require('gruvbox').setup({
  overrides = {
    Comment = { italic = false },
    Conditional = { fg = palette.bright_red, italic = true },
    Repeat = { fg = palette.bright_red, italic = true },
    Label = { fg = palette.bright_red, italic = true },
    Operator = { fg = palette.bright_orange, italic = false },
    Keyword = { fg = palette.bright_red, italic = true },
    Exception = { fg = palette.bright_red, italic = true },
    String = { italic = false },
    LspSignatureActiveParameter = { underline = true },
  }
})
vim.cmd('colorscheme gruvbox')
