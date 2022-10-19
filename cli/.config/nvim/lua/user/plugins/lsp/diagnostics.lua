local M = {}

local augroup = vim.api.nvim_create_augroup('user.plugins.lsp.diagnostics', { clear = true })

M.icons = {
  error = ' ',
  warn  = ' ',
  hint  = ' ',
  info  = ' ',
}

local function open_float()
  vim.diagnostic.open_float(nil, {
    scope = 'cursor',
    header = '',
    source = false,
    focusable = false,
    border = 'single',
    close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter' },
  })
end

function M.setup()
  vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
  })

  vim.fn.sign_define('DiagnosticSignError', { text = M.icons.error, texthl = 'DiagnosticSignError', numhl = '' })
  vim.fn.sign_define('DiagnosticSignWarn', { text = M.icons.warn, texthl = 'DiagnosticSignWarn', numhl = '' })
  vim.fn.sign_define('DiagnosticSignHint', { text = M.icons.hint, texthl = 'DiagnosticSignHint', numhl = '' })
  vim.fn.sign_define('DiagnosticSignInfo', { text = M.icons.info, texthl = 'DiagnosticSignInfo', numhl = '' })
end

function M.on_attach(client, bufnr)
  if not client.supports_method('textDocument/publishDiagnostics') then
    return
  end

  vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
  vim.api.nvim_create_autocmd('CursorHold', { group = augroup, buffer = bufnr, callback = function () open_float() end })
end

return M
