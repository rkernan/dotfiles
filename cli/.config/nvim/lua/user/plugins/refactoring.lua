require('refactoring').setup({})
require('telescope').load_extension('refactoring')

vim.keymap.set('v', '<leader>rr', require('telescope').extensions.refactoring.refactors, { desc = 'Refactoring' })
