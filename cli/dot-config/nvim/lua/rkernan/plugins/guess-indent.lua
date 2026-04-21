vim.pack.add({ 'https://github.com/NMAC427/guess-indent.nvim.git' }, { confirm = false })
require('guess-indent').setup({ disable_on_editorconfig = true })
