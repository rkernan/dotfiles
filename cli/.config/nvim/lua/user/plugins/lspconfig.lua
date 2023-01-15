require('mason').setup()

require('mason-lspconfig').setup({
  ensure_installed = {
    'jsonls',
    'pyright',
    'sumneko_lua',
  }
})

require('neodev').setup({})

local lspconfig = require('lspconfig')
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

require('mason-lspconfig').setup_handlers({
  function (server_name)
    lspconfig[server_name].setup({ capabilities = lsp_capabilities })
  end,
})