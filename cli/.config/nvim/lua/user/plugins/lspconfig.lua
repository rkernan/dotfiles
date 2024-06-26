return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'folke/neodev.nvim',
    'SmiteshP/nvim-navic',
    'ray-x/lsp_signature.nvim',
  },
  event = { 'BufNewFile', 'BufReadPost' },
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
            -- enable lsp signature help
            require('lsp_signature').on_attach({}, bufnr)
            -- enable navic if server supports document symbols
            if client.server_capabilities.documentSymbolProvider then
              require('nvim-navic').attach(client, bufnr)
            end
          end
        })
      end,
    })
  end,
}
