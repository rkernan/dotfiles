local function lsp_attach(args)
  local bufnr = args.buf
  vim.keymap.set('n', '[d', vim.diagnostic.goto_next, { buffer = bufnr, desc = 'LSP next diagnostic' })
  vim.keymap.set('n', ']d', vim.diagnostic.goto_prev, { buffer = bufnr, desc = 'LSP prev diagnostic' })
  vim.keymap.set('n', 'K', vim.lsp.buf.signature_help, { buffer = bufnr, desc = 'LSP signature help' })
  vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, { buffer = bufnr, desc = 'LSP signature help' })
  vim.keymap.set('n', '<Leader><Leader>f', vim.lsp.buf.format, { buffer = bufnr, desc = 'LSP format buffer' })
  vim.keymap.set('n', '<Leader><Leader>a', vim.lsp.buf.code_action, { buffer = bufnr, desc = 'LSP code actions' })
end

local function lsp_detach(args)
  local bufnr = args.buf
  vim.keymap.del('n', '[d', { buffer = bufnr })
  vim.keymap.del('n', ']d', { buffer = bufnr })
  vim.keymap.del('n', 'K', { buffer = bufnr })
  vim.keymap.del('i', '<C-k>', { buffer = bufnr })
  vim.keymap.del('n', '<Leader><Leader>f', { buffer = bufnr })
  vim.keymap.del('n', '<Leader><Leader>a', { buffer = bufnr })
end

local augroup = vim.api.nvim_create_augroup('lsp.mappings', { clear = true })
vim.api.nvim_create_autocmd('LspAttach', { group = augroup, callback = lsp_attach })
vim.api.nvim_create_autocmd('LspDetach', { group = augroup, callback = lsp_detach })
