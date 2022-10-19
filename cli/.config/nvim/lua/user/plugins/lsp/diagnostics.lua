local M = {}

M.icons = {
  error = ' ',
  warn  = ' ',
  hint  = ' ',
  info  = ' ',
}

function open_float()
  vim.diagnostic.open_float(nil, {
    scope = 'cursor',
    header = '',
    source = false,
    focusable = false,
    border = 'single',
    close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter' },
  })
end

function M.on_attach(client, buffer)
  local group = vim.api.nvim_create_augroup('user.plugins.lsp.diagnostics', { clear = false })
  vim.api.nvim_clear_autocmds({ buffer = buffer, group = group })
  vim.api.nvim_create_autocmd('CursorHold', { buffer = buffer, group = group, callback = function () open_float() end })
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

return M
