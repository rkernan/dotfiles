local function lsp_attach(args)
  local bufnr = args.buf
  vim.keymap.set('n', '[d', vim.diagnostic.goto_next, { buffer = bufnr, desc = 'LSP next diagnostic' })
  vim.keymap.set('n', ']d', vim.diagnostic.goto_prev, { buffer = bufnr, desc = 'LSP prev diagnostic' })

  vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, desc = 'LSP signature help' })
  vim.keymap.set('i', '<c-k>', vim.lsp.buf.signature_help, { buffer = bufnr, desc = 'LSP signature help' })

  vim.keymap.set('n', '<leader><leader>f', vim.lsp.buf.format, { buffer = bufnr, desc = 'LSP format buffer' })
  vim.keymap.set('n', '<leader><leader>a', vim.lsp.buf.code_action, { buffer = bufnr, desc = 'LSP code actions' })

  local builtin = require('telescope.builtin')
  vim.keymap.set('n', '<leader>e', function () builtin.diagnostics({ bufnr = 0 }) end, { buffer = bufnr, desc = 'LSP diagnostics' })
  vim.keymap.set('n', '<leader><leader>r', builtin.lsp_references, { buffer = bufnr, desc = 'LSP references' })
  vim.keymap.set('n', '<leader><leader>i', builtin.lsp_implementations, { buffer = bufnr, desc = 'LSP implementations' })
  vim.keymap.set('n', '<leader><leader>d', builtin.lsp_definitions, { buffer = bufnr, desc = 'LSP definitions' })
  vim.keymap.set('n', '<leader><leader>t', builtin.lsp_type_definitions, { buffer = bufnr, desc = 'LSP typedefs' })
  vim.keymap.set('n', '<leader><leader>s', builtin.lsp_document_symbols, { buffer = bufnr, desc = 'LSP document symbols' })
end

local function lsp_detach(args)
  local bufnr = args.buf
  vim.keymap.del('n', '[d', { buffer = bufnr })
  vim.keymap.del('n', ']d', { buffer = bufnr })

  vim.keymap.del('n', 'K', { buffer = bufnr })
  vim.keymap.del('i', '<c-k>', { buffer = bufnr })

  vim.keymap.del('n', '<leader><leader>f', { buffer = bufnr })
  vim.keymap.del('n', '<leader><leader>a', { buffer = bufnr })

  vim.keymap.del('n', '<leader>e', { buffer = bufnr })
  vim.keymap.del('n', '<leader><leader>r', { buffer = bufnr })
  vim.keymap.del('n', '<leader><leader>i', { buffer = bufnr })
  vim.keymap.del('n', '<leader><leader>d', { buffer = bufnr })
  vim.keymap.del('n', '<leader><leader>t', { buffer = bufnr })
  vim.keymap.del('n', '<leader><leader>s', { buffer = bufnr })
end

local augroup = vim.api.nvim_create_augroup('plugins.lsp', { clear = true })
vim.api.nvim_create_autocmd('LspAttach', { group = augroup, callback = lsp_attach })
vim.api.nvim_create_autocmd('LspDetach', { group = augroup, callback = lsp_detach })

require('plugins.lsp.diagnostics')
require('plugins.lsp.progress')

local capabilities = require('cmp_nvim_lsp').default_capabilities()
require('plugins.lsp.servers.jsonls').setup(capabilities)
require('plugins.lsp.servers.null-ls').setup(capabilities)
require('plugins.lsp.servers.pyright').setup(capabilities)
require('plugins.lsp.servers.sumneko_lua').setup(capabilities)
