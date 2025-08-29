---@diagnostic disable: undefined-global
local add = MiniDeps.add
---@diagnostic enable: undefined-global

add({ source = 'neovim/nvim-lspconfig' })

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

local diagnostic_signs = require('rkernan.diagnostics')
vim.diagnostic.config({
  severity_sort = true,
  virtual_text = false,
  signs = {
    text = diagnostic_signs.signs,
  },
  update_in_insert = false,
  float = {
    border = 'single',
    header = '',
    source = true,
    prefix = function (diagnostic)
      local sign = string.format('%s ', diagnostic_signs.signs[diagnostic.severity])
      local hl = diagnostic_signs.sign_hl[diagnostic.severity]
      return sign, hl
    end,
  },
})
