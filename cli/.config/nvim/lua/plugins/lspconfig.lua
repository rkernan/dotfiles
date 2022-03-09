-- add additional caps supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- setup buffer when language server starts
local on_attach = function(client, bufnr)
  -- TODO neovim 0.7.0 - bind multiple modes at once
  -- TODO neovim 0.7.0 - pass lua functions to map
  -- code actions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader><leader>a', "<cmd>lua vim.lsp.buf.code_action()<cr>", { noremap = true })
  vim.api.nvim_buf_set_keymap(bufnr, 'v', '<leader><leader>a', "<cmd>lua vim.lsp.buf.range_code_action()<cr>", { noremap = true })
  -- diagnostics - buffer
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', "<cmd>FzfLua lsp_document_diagnostics<cr>", { noremap = true })
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.diagnostics.goto_prev()<cr>', { noremap = true })
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.diagnostics.goto_next()<cr>', { noremap = true })
  -- format
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader><leader>a', "<cmd>lua vim.lsp.buf.formatting()<cr>", { noremap = true })
  vim.api.nvim_buf_set_keymap(bufnr, 'v', '<leader><leader>a', "<cmd>lua vim.lsp.buf.range_formatting()<cr>", { noremap = true })
  -- goto
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader><leader>r', "<cmd>FzfLua lsp_references<cr>", { noremap = true })
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader><leader>i', "<cmd>FzfLua lsp_implementations<cr>", { noremap = true })
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader><leader>d', "<cmd>FzfLua lsp_definitions<cr>", { noremap = true })
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader><leader>D', "<cmd>FzfLua lsp_declarations<cr>", { noremap = true })
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader><leader>t', "<cmd>FzfLua lsp_typedefs<cr>", { noremap = true })
  -- hover doc
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', { noremap = true })
  vim.api.nvim_buf_set_keymap(bufnr, 'i', '<c-k>', "<cmd>lua vim.lsp.buf.signature_help()<cr>", { noremap = true })
  -- symbols
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader><leader>s', "<cmd>FzfLua lsp_document_symbols<cr>", { noremap = true })
end

local servers = { 'bashls', 'pyright' }
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
