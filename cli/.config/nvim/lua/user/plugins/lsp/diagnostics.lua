local M = {}

M.icons = {
  error = ' ',
  warn  = ' ',
  hint  = ' ',
  info  = ' ',
}

M.open_float = function()
  vim.diagnostic.open_float(nil, {
    scope = 'cursor',
    header = '',
    source = false,
    focusable = false,
    border = 'single',
    close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter' },
  })
end

M.on_attach = function(client, buffer)
  vim.api.nvim_create_autocmd('CursorHold', { buffer = buffer, callback = M.open_float })
  vim.keymap.set('n', '<c-e>', M.open_float, { buffer = buffer })
end

M.setup = function()
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
