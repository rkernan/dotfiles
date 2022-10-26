local function lsp_attach(args)
  local bufnr = args.buf
  vim.keymap.set('n', '[d', vim.diagnostic.goto_next, { buffer = bufnr, desc = 'LSP next diagnostic' })
  vim.keymap.set('n', ']d', vim.diagnostic.goto_prev, { buffer = bufnr, desc = 'LSP prev diagnostic' })
  vim.keymap.set('n', '<leader><leader>f', vim.lsp.buf.format, { buffer = bufnr, desc = 'LSP format buffer' })
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, desc = 'LSP signature help' })
  vim.keymap.set('i', '<c-k>', vim.lsp.buf.signature_help, { buffer = bufnr, desc = 'LSP signature help' })
end

local function lsp_detach(args)
  local bufnr = args.buf
  vim.keymap.del('n', '[d', { buffer = bufnr })
  vim.keymap.del('n', ']d', { buffer = bufnr })
  vim.keymap.del('n', '<leader><leader>f', { buffer = bufnr })
  vim.keymap.del('n', 'K', { buffer = bufnr })
  vim.keymap.del('i', '<c-k>', { buffer = bufnr })
end

local augroup = vim.api.nvim_create_augroup('user.plugins.lsp', { clear = true })
vim.api.nvim_create_autocmd('LspAttach', { group = augroup, callback = lsp_attach })
vim.api.nvim_create_autocmd('LspDetach', { group = augroup, callback = lsp_detach })

require('user.plugins.lsp.diagnostics')
require('user.plugins.lsp.fzf')
require('user.plugins.lsp.progress')
require('user.plugins.lsp.lightbulb')

local capabilities = require('user.plugins.lsp.cmp').get_capabilities()
require('user.plugins.lsp.servers.jsonls').setup(capabilities)
require('user.plugins.lsp.servers.null-ls').setup(capabilities)
require('user.plugins.lsp.servers.pyright').setup(capabilities)
require('user.plugins.lsp.servers.sumneko_lua').setup(capabilities)
