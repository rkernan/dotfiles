local M = {}

M.setup = function (on_attach, capabilities, lsp_flags)
  require('lspconfig').pyright.setup({ on_attach = on_attach, capabilities = capabilities, lsp_flags = lsp_flags or {} })
end

return M
