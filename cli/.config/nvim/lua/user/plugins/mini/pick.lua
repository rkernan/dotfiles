local function lsp_attach(args)
  local bufnr = args.buf
  vim.keymap.set('n', 'gD', function () require('mini.extra').pickers.lsp({ scope = 'declaration' }) end, { buffer = bufnr, desc = 'LSP declaration' })
  vim.keymap.set('n', 'gd', function () require('mini.extra').pickers.lsp({ scope = 'definition' }) end, { buffer = bufnr, desc = 'LSP definition' })
  vim.keymap.set('n', 'gi', function () require('mini.extra').pickers.lsp({ scope = 'implementation' }) end, { buffer = bufnr, desc = 'LSP implementation' })
  vim.keymap.set('n', 'gr', function () require('mini.extra').pickers.lsp({ scope = 'references' }) end, { buffer = bufnr, desc = 'LSP references' })
  vim.keymap.set('n', '<Leader>D', function () require('mini.extra').pickers.lsp({ scope = 'type_definition' }) end, { buffer = bufnr, desc = 'LSP type definitions' })
  vim.keymap.set('n', '<Leader><Leader>d', function () require('mini.extra').pickers.lsp({ scope = 'document_symbol' }) end, { buffer = bufnr, desc = 'LSP document symbols' })
  vim.keymap.set('n', '<Leader><Leader>w', function () require('mini.extra').pickers.lsp({ scope = 'workspace_symbol' }) end, { buffer = bufnr, desc = 'LSP workspace symbols' })
end

local function lsp_detach(args)
  local bufnr = args.buf
  vim.keymap.del('n', 'gD', { buffer = bufnr })
  vim.keymap.del('n', 'gd', { buffer = bufnr })
  vim.keymap.del('n', 'gi', { buffer = bufnr })
  vim.keymap.del('n', 'gr', { buffer = bufnr })
  vim.keymap.del('n', '<Leader>D', { buffer = bufnr })
  vim.keymap.del('n', '<Leader><Leader>d', { buffer = bufnr })
  vim.keymap.del('n', '<Leader><Leader>w', { buffer = bufnr })
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
