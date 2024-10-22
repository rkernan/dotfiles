local function lsp_attach(args)
  local client = vim.lsp.get_client_by_id(args.data.client_id)
  if not client then
    return
  end

  local bufnr = args.buf
  vim.keymap.set('n', '<Leader><Leader>i', function () require('mini.extra').pickers.lsp({ scope = 'implementation' }) end, { buffer = bufnr, desc = 'LSP implementation' })
  vim.keymap.set('n', '<Leader><Leader>r', function () require('mini.extra').pickers.lsp({ scope = 'references' }) end, { buffer = bufnr, desc = 'LSP references' })
  vim.keymap.set('n', '<Leader><Leader>o', function () require('mini.extra').pickers.lsp({ scope = 'document_symbol' }) end, { buffer = bufnr, desc = 'LSP document symbols' })
  vim.keymap.set('n', '<Leader><Leader>O', function () require('mini.extra').pickers.lsp({ scope = 'workspace_symbol' }) end, { buffer = bufnr, desc = 'LSP workspace symbols' })
end

local function lsp_detach(args)
  local bufnr = args.buf
  vim.keymap.del('n', '<Leader><Leader>i', { buffer = bufnr })
  vim.keymap.del('n', '<Leader><Leader>r', { buffer = bufnr })
  vim.keymap.del('n', '<Leader><Leader>o', { buffer = bufnr })
  vim.keymap.del('n', '<Leader><Leader>O', { buffer = bufnr })
end

local keys = {
  { '<Leader>f', function () require('mini.pick').builtin.files() end, desc = 'Files' },
  { '<Leader>pf', function () require('mini.extra').pickers.git_files() end, desc = 'Git files' },
  { '<Leader>b', function () require('mini.pick').builtin.buffers() end, desc = 'Buffers' },
  { '<Leader>/', function () require('mini.pick').builtin.grep_live() end, desc = 'Live grep' },
  { '<Leader>e', function () require('mini.extra').pickers.diagnostic({ scope = 'current' }) end, desc = 'Diagnostics' },
  { '<Leader>E', function () require('mini.extra').pickers.diagnostic({ scope = 'all' }) end, desc = 'Workspace diagnostics' },
}

local function setup()
  require('mini.pick').setup()

  local augroup = vim.api.nvim_create_augroup('rkernan.plugins.mini.pick', { clear = true })
  vim.api.nvim_create_autocmd('LspAttach', { group = augroup, callback = lsp_attach })
  vim.api.nvim_create_autocmd('LspDetach', { group = augroup, callback = lsp_detach })
end


return { keys = keys, setup = setup }
