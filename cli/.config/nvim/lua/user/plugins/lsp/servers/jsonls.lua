local M = {}

function M.setup(on_attach, capabilities, lsp_flags)
  require('lspconfig').jsonls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    lsp_flags = lsp_flags or {},
  })
end

return M
