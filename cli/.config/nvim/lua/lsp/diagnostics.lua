local lsp_utils = require('lsp.utils')
local augroup = vim.api.nvim_create_augroup('lsp.diagnostics', { clear = true })

local function open_float(args)
  local bufnr = args.buf
  vim.diagnostic.open_float({
    bufnr = bufnr,
    scope = 'cursor',
    header = '',
    source = false,
    focusable = false,
    border = 'single',
    close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter' },
  })
end

local function lsp_attach(args)
  local bufnr = args.buf
  if vim.b[bufnr].user_lsp_diagnostics_enabled or not lsp_utils.buf_supports_method(bufnr, 'textDocument/publishDiagnostics') then
    -- already seutp or diagnostics not supported
    return
  end
  -- create CursorHold autocommands
  vim.api.nvim_create_autocmd('CursorHold', { group = augroup, buffer = bufnr, callback = open_float })
  -- set enabled buffer flag
  vim.b[bufnr].user_lsp_diagnostics_enabled = true
end

local function lsp_detach(args)
  local bufnr = args.buf
  if lsp_utils.buf_supports_method(bufnr, 'textDocument/publishDiagnostics') then
    -- some attached client still supports diagnostics
    return
  end
  -- clear buffer autocommands
  vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
  -- set disabled buffer flag
  vim.b[bufnr].user_lsp_diagnostics_enabled = false
end

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

local M = {}

M.icons = {
  error = ' ',
  warn  = ' ',
  hint  = ' ',
  info  = ' ',
}

vim.fn.sign_define('DiagnosticSignError', { text = M.icons.error, texthl = 'DiagnosticSignError', numhl = '' })
vim.fn.sign_define('DiagnosticSignWarn', { text = M.icons.warn, texthl = 'DiagnosticSignWarn', numhl = '' })
vim.fn.sign_define('DiagnosticSignHint', { text = M.icons.hint, texthl = 'DiagnosticSignHint', numhl = '' })
vim.fn.sign_define('DiagnosticSignInfo', { text = M.icons.info, texthl = 'DiagnosticSignInfo', numhl = '' })

vim.api.nvim_create_autocmd('LspAttach', { group = augroup, callback = lsp_attach })
vim.api.nvim_create_autocmd('LspDetach', { group = augroup, callback = lsp_detach })

return M
