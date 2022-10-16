local lspconfig = require('lspconfig')
local capabilities = require('user.plugins.lsp.cmp').get_capabilities()

-- setup buffer when language server starts
local function on_attach(client, buffer)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_next, { buffer = buffer, desc = 'LSP next diagnostic' })
  vim.keymap.set('n', ']d', vim.diagnostic.goto_prev, { buffer = buffer, desc = 'LSP prev diagnostic' })

  vim.keymap.set('n', '<leader><leader>f', vim.lsp.buf.format, { buffer = buffer, desc = 'LSP format buffer' })

  vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = buffer, desc = 'LSP signature help' })
  vim.keymap.set('i', '<c-k>', vim.lsp.buf.signature_help, { buffer = buffer, desc = 'LSP signature help' })

  require('user.plugins.lsp.fzf').on_attach(client, buffer)
  require('user.plugins.lsp.diagnostics').on_attach(buffer)
end

require('user.plugins.lsp.diagnostics').setup()

require('user.plugins.lsp.servers.null-ls').setup(on_attach, capabilities)
require('user.plugins.lsp.servers.pyright').setup(on_attach, capabilities)
require('user.plugins.lsp.servers.sumneko_lua').setup(on_attach, capabilities)
