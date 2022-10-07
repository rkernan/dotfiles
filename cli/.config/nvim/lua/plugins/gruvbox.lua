local palette = require('gruvbox.palette')

require('gruvbox').setup({
  overrides = {
    Keyword = { fg = palette.bright_red, italic = true },
    String = { italic = false },
    LspSignatureActiveParameter = { fg = palette.bright_aqua, bold = true}
  }
})
vim.cmd('colorscheme gruvbox')
