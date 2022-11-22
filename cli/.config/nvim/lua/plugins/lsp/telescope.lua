local function lsp_attach(args)
  local bufnr = args.buf
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
  vim.keymap.del('n', '<leader>e', { buffer = bufnr })
  vim.keymap.del('n', '<leader><leader>r', { buffer = bufnr })
  vim.keymap.del('n', '<leader><leader>i', { buffer = bufnr })
  vim.keymap.del('n', '<leader><leader>d', { buffer = bufnr })
  vim.keymap.del('n', '<leader><leader>t', { buffer = bufnr })
  vim.keymap.del('n', '<leader><leader>s', { buffer = bufnr })
end

local augroup = vim.api.nvim_create_augroup('plugins.lsp.fzf', { clear = true })
vim.api.nvim_create_autocmd('LspAttach', { group = augroup, callback = lsp_attach })
vim.api.nvim_create_autocmd('LspDetach', { group = augroup, callback = lsp_detach })
