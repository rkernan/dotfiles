local M = {}

M.on_attach = function (client, buffer)
  local fzf = require('fzf-lua')
  local fzf_winopts = { preview = { layout = 'vertical', vertical = 'down:60%' }}
  vim.keymap.set('n', '<leader><leader>a', function () fzf.lsp_code_actions() end, { buffer = buffer })
  vim.keymap.set('n', '<leader>e', function () fzf.diagnostics_document({ winopts = fzf_winopts }) end, { buffer = buffer })
  vim.keymap.set('n', '<leader><leader>r', function () fzf.lsp_references({ winopts = fzf_winopts  }) end, { buffer = buffer })
  vim.keymap.set('n', '<leader><leader>i', function () fzf.lsp_implementations({ winopts = fzf_winopts }) end, { buffer = buffer })
  vim.keymap.set('n', '<leader><leader>d', function () fzf.lsp_definitions({ winopts = fzf_winopts }) end, { buffer = buffer })
  vim.keymap.set('n', '<leader><leader>D', function () fzf.lsp_declarations({ winopts = fzf_winopts }) end, { buffer = buffer })
  vim.keymap.set('n', '<leader><leader>t', function () fzf.lsp_typedefs({ winopts = fzf_winopts }) end, { buffer = buffer })
  vim.keymap.set('n', '<leader><leader>s', fzf.lsp_document_symbols, { buffer = buffer })
end

return M
