return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'folke/neodev.nvim',
    'SmiteshP/nvim-navic',
  },
  event = { 'BufNew', 'BufRead '},
  cmd = 'Mason',
  config = function ()
    require('mason').setup()

    require('mason-lspconfig').setup({
      ensure_installed = {
        'jsonls',
        'lua_ls',
        'pyright',
      }
    })

    require('neodev').setup({})

    local lspconfig = require('lspconfig')
    local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

    require('mason-lspconfig').setup_handlers({
      function (server_name)
        lspconfig[server_name].setup({
          capabilities = lsp_capabilities,
          on_attach = function (client, bufnr)
            if client.server_capabilities.documentSymbolProvider then
              require('nvim-navic').attach(client, bufnr)
            end
          end
        })
      end,
    })
  end,
}
