-- add additional caps supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()

if pcall(require, 'cmp_nvim_lsp') then
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
end

-- for keybindings
local fzf = require('fzf-lua')

-- sort diagnostics by severity
vim.diagnostic.config({
  severity_sort = true,
  virtual_text = false,
})

-- setup buffer when language server starts
local function on_attach(_, buffer)
  -- setup signature
  if pcall(require, 'lsp_signature') then
    require('lsp_signature').on_attach({
      bind = true,
      hint_enable = false,
      handler_opts = { border = 'none' }
    }, buffer)
  end

  local fzf_winopts = { preview = { layout = 'vertical', vertical = 'down:60%' }}
  -- code actions
  vim.keymap.set('n', '<leader><leader>a', vim.lsp.buf.code_action, { buffer = buffer })
  vim.keymap.set('v', '<leader><leader>a', vim.lsp.buf.range_code_action, { buffer = buffer })
  -- diagnostics - buffer
  vim.keymap.set('n', '<leader>e', function () fzf.lsp_document_diagnostics({ winopts = fzf_winopts }) end, { buffer = buffer })
  vim.keymap.set('n', '<c-e>', function () vim.diagnostic.open_float(nil, { focus = false }) end, { buffer = buffer })
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { buffer = buffer })
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { buffer = buffer })
  -- format
  vim.keymap.set('n', '<leader><leader>a', vim.lsp.buf.formatting, { buffer = buffer })
  vim.keymap.set('v', '<leader><leader>a', vim.lsp.buf.range_formatting, { buffer = buffer })
  -- goto
  vim.keymap.set('n', '<leader><leader>r', function () fzf.lsp_references({ winopts = fzf_winopts  }) end, { buffer = buffer })
  vim.keymap.set('n', '<leader><leader>i', function () fzf.lsp_implementations({ winopts = fzf_winopts }) end, { buffer = buffer })
  vim.keymap.set('n', '<leader><leader>d', function () fzf.lsp_definitions({ winopts = fzf_winopts }) end, { buffer = buffer })
  vim.keymap.set('n', '<leader><leader>D', function () fzf.lsp_declarations({ winopts = fzf_winopts }) end, { buffer = buffer })
  vim.keymap.set('n', '<leader><leader>t', function () fzf.lsp_typedefs({ winopts = fzf_winopts }) end, { buffer = buffer })
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
