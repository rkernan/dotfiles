-- add additional caps supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- for keybindings
local fzf = require('fzf-lua')

-- sort diagnostics by severity
vim.diagnostic.config({ severity_sort = true })

-- setup buffer when language server starts
local on_attach = function(client, buffer)
  -- code actions
  vim.keymap.set('n', '<leader><leader>a', vim.lsp.buf.code_action, { buffer = buffer })
  vim.keymap.set('v', '<leader><leader>a', vim.lsp.buf.range_code_action, { buffer = buffer })
  -- diagnostics - buffer
  vim.keymap.set('n', '<leader>e', fzf.lsp_document_diagnostics, { buffer = buffer })
  vim.keymap.set('n', '<c-e>', function () vim.diagnostic.open_float(nil, { focus = false }) end, { buffer = buffer })
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { buffer = buffer })
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { buffer = buffer })
  -- format
  vim.keymap.set('n', '<leader><leader>a', vim.lsp.buf.formatting, { buffer = buffer })
  vim.keymap.set('v', '<leader><leader>a', vim.lsp.buf.range_formatting, { buffer = buffer })
  -- goto
  vim.keymap.set('n', '<leader><leader>r', fzf.lsp_references, { buffer = buffer })
  vim.keymap.set('n', '<leader><leader>i', fzf.lsp_implementations, { buffer = buffer })
  vim.keymap.set('n', '<leader><leader>d', fzf.lsp_definitions, { buffer = buffer })
  vim.keymap.set('n', '<leader><leader>D', fzf.lsp_declarations, { buffer = buffer })
  vim.keymap.set('n', '<leader><leader>t', fzf.lsp_typedefs, { buffer = buffer })
  -- hover doc
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = buffer })
  vim.keymap.set('i', '<c-k>', vim.lsp.buf.signature_help, { buffer = buffer })
  -- symbols
  vim.keymap.set('n', '<leader><leader>s', fzf.lsp_document_symbols, { buffer = buffer })
end

local servers = { 'bashls', 'jsonls', 'pyright', 'yamlls' }
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup({
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    }
  })
end

-- custom sumneko server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
require('lspconfig').sumneko_lua.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
})
