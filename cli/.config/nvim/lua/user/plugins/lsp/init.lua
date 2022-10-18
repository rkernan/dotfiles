local capabilities = require('user.plugins.lsp.cmp').get_capabilities()

-- setup buffer when language server starts
local function on_attach(client, bufnr)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_next, { buffer = bufnr, desc = 'LSP next diagnostic' })
  vim.keymap.set('n', ']d', vim.diagnostic.goto_prev, { buffer = bufnr, desc = 'LSP prev diagnostic' })

  vim.keymap.set('n', '<leader><leader>f', vim.lsp.buf.format, { buffer = bufnr, desc = 'LSP format buffer' })

  vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, desc = 'LSP signature help' })
  vim.keymap.set('i', '<c-k>', vim.lsp.buf.signature_help, { buffer = bufnr, desc = 'LSP signature help' })

  require('user.plugins.lsp.fzf').on_attach(client, bufnr)
  require('user.plugins.lsp.diagnostics').on_attach(bufnr)
  require('user.plugins.lsp.progress').on_attach(client, bufnr)
end

require('user.plugins.lsp.diagnostics').setup()
require('user.plugins.lsp.progress').setup()

require('user.plugins.lsp.servers.jsonls').setup(on_attach, capabilities)
require('user.plugins.lsp.servers.null-ls').setup(on_attach, capabilities)
require('user.plugins.lsp.servers.pyright').setup(on_attach, capabilities)
require('user.plugins.lsp.servers.sumneko_lua').setup(on_attach, capabilities)
