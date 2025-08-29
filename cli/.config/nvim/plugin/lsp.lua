local function lsp_attach(args)
  local client = vim.lsp.get_client_by_id(args.data.client_id)
  if not client then
    return
  end

  local bufnr = args.buf

  vim.keymap.set('n', '<C-e>', function () vim.diagnostic.open_float() end, { desc = 'Open diagnostic float' })
  vim.keymap.set({ 'i', 'v', }, '<C-s>', function () vim.lsp.buf.hover({ border = 'single' }) end, { buffer = bufnr, desc = 'LSP hover' })
  vim.keymap.set('n', 'S', function () vim.lsp.buf.hover({ border = 'single' }) end, { buffer = bufnr, desc = 'LSP hover' })
  vim.keymap.set('n', 'grr', function () require('mini.extra').pickers.lsp({ scope = 'references' }) end, { buffer = bufnr, desc = 'LSP references' })
  vim.keymap.set('n', 'gO', function () require('mini.extra').pickers.lsp({ scope = 'document_symbol' }) end, { buffer = bufnr, desc = 'LSP document symbols' })
end

local augroup = vim.api.nvim_create_augroup('rkernan.lsp', { clear = true })
vim.api.nvim_create_autocmd('LspAttach', { group = augroup, callback = lsp_attach })

vim.lsp.enable({
  "bashls",
  "clangd",
  "gopls",
  "groovyls",
  "jsonls",
  "lua_ls",
  "yamlls",
})

if vim.fn.executable('pyright-langserver') > 0 then
  vim.lsp.enable('pyright')
else
  vim.lsp.enable('basedpyright')
end

vim.diagnostic.config({
  virtual_text = false,
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰔶',
      [vim.diagnostic.severity.WARN]  = '󰔶',
      [vim.diagnostic.severity.INFO]  = '󰝤',
      [vim.diagnostic.severity.HINT]  = '󰝤',
    },
  },
})
