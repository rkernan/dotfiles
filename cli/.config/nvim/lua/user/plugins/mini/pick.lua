local function lsp_attach(args)
  local client = vim.lsp.get_client_by_id(args.data.client_id)
  if not client then
    return
  end

  local bufnr = args.buf

  if client.supports_method('textDocument/declaration*') then
    vim.keymap.set('n', 'gD', function () require('mini.extra').pickers.lsp({ scope = 'declaration' }) end, { buffer = bufnr, desc = 'LSP declaration' })
  end

  if client.supports_method('textDocument/definition') then
    vim.keymap.set('n', 'gd', function () require('mini.extra').pickers.lsp({ scope = 'definition' }) end, { buffer = bufnr, desc = 'LSP definition' })
  end

  if client.supports_method('textDocument/implementation*') then
    vim.keymap.set('n', 'gi', function () require('mini.extra').pickers.lsp({ scope = 'implementation' }) end, { buffer = bufnr, desc = 'LSP implementation' })
  end

  if client.supports_method('textDocument/references') then
    vim.keymap.set('n', 'gR', function () require('mini.extra').pickers.lsp({ scope = 'references' }) end, { buffer = bufnr, desc = 'LSP references' })
  end

  if client.supports_method('textDocument/typeDefinition*') then
    vim.keymap.set('n', '<Leader>D', function () require('mini.extra').pickers.lsp({ scope = 'type_definition' }) end, { buffer = bufnr, desc = 'LSP type definitions' })
  end

  if client.supports_method('textDocument/documentSymbol') then
    vim.keymap.set('n', '<Leader><Leader>d', function () require('mini.extra').pickers.lsp({ scope = 'document_symbol' }) end, { buffer = bufnr, desc = 'LSP document symbols' })
  end

  if client.supports_method('workspace/symbol') then
    vim.keymap.set('n', '<Leader><Leader>w', function () require('mini.extra').pickers.lsp({ scope = 'workspace_symbol' }) end, { buffer = bufnr, desc = 'LSP workspace symbols' })
  end
end

local function lsp_detach(args)
  local client = vim.lsp.get_client_by_id(args.data.client_id)
  if not client then
    return
  end

  local bufnr = args.buf

  if client.supports_method('textDocument/declaration*') then
    vim.keymap.del('n', 'gD', { buffer = bufnr })
  end

  if client.supports_method('textDocument/definition') then
    vim.keymap.del('n', 'gd', { buffer = bufnr })
  end

  if client.supports_method('textDocument/implementation*') then
    vim.keymap.del('n', 'gi', { buffer = bufnr })
  end

  if client.supports_method('textDocument/references') then
    vim.keymap.del('n', 'gR', { buffer = bufnr })
  end

  if client.supports_method('textDocument/typeDefinition*') then
    vim.keymap.del('n', '<Leader>D', { buffer = bufnr })
  end

  if client.supports_method('textDocument/documentSymbol') then
    vim.keymap.del('n', '<Leader><Leader>d', { buffer = bufnr })
  end

  if client.supports_method('workspace/symbol') then
    vim.keymap.del('n', '<Leader><Leader>w', { buffer = bufnr })
  end
end

local keys = {
  { '<Leader>f', function () require('mini.pick').builtin.files() end, desc = 'Files' },
  { '<Leader>b', function () require('mini.pick').builtin.buffers() end, desc = 'Buffers' },
  { '<Leader>/', function () require('mini.pick').builtin.grep_live() end, desc = 'Live grep' },
  { '<Leader>e', function () require('mini.extra').pickers.diagnostic({ scope = 'current' }) end, desc = 'Diagnostics' },
  { '<Leader>E', function () require('mini.extra').pickers.diagnostic({ scope = 'all' }) end, desc = 'Workspace diagnostics' },
}

local function setup()
  require('mini.pick').setup()

  local augroup = vim.api.nvim_create_augroup('plugins.mini.pick', { clear = true })
  vim.api.nvim_create_autocmd('LspAttach', { group = augroup, callback = lsp_attach })
  vim.api.nvim_create_autocmd('LspDetach', { group = augroup, callback = lsp_detach })
end


return { keys = keys, setup = setup }
