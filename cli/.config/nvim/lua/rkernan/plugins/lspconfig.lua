local function lsp_attach(args)
  local client = vim.lsp.get_client_by_id(args.data.client_id)
  if not client then
    return
  end

  local bufnr = args.buf

  vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })

  vim.keymap.set({ 'i', 'v', }, '<C-s>', function () vim.lsp.buf.hover({ border = 'single' }) end, { buffer = bufnr, desc = 'LSP hover' })
  vim.keymap.set('n', 'S', function () vim.lsp.buf.hover({ border = 'single' }) end, { buffer = bufnr, desc = 'LSP hover' })
  vim.keymap.set('n', 'grr', function () require('mini.extra').pickers.lsp({ scope = 'references' }) end, { buffer = bufnr, desc = 'LSP references' })
  vim.keymap.set('n', 'gO', function () require('mini.extra').pickers.lsp({ scope = 'document_symbol' }) end, { buffer = bufnr, desc = 'LSP document symbols' })
end

local function lsp_detach(args)
  local bufnr = args.buf
  pcall(vim.keymap.del, 'n', 'S', { buffer = bufnr })
end

---@diagnostic disable: undefined-global
local add = MiniDeps.add
---@diagnostic enable: undefined-global

add({ source = 'neovim/nvim-lspconfig' })

local lspconfig = require('lspconfig')
local lsp_defaults = { capabilities = lspconfig.util.default_config.capabilities }

lspconfig.bashls.setup(lsp_defaults)
lspconfig.clangd.setup(lsp_defaults)
lspconfig.gopls.setup(lsp_defaults)
lspconfig.groovyls.setup(vim.tbl_deep_extend('force', lsp_defaults, {
  cmd = {
    'java', '-jar', vim.fn.expand('~/.local/lib/groovy-language-server/build/libs/groovy-language-server-all.jar')
  },
}))
lspconfig.jsonls.setup(lsp_defaults)
lspconfig.lua_ls.setup(vim.tbl_deep_extend('force', lsp_defaults, {
  settings =
    {
      Lua = {
        telemetry = {
          enable = false
        }
      }
    },
  on_init = function (client)
    local path = client.workspace_folders[1].name

    -- Don't do anything if there is project local config
    if vim.uv.fs_stat(vim.fs.joinpath(path, '.luarc.json')) or vim.uv.fs_stat(vim.fs.joinpath(path, '.luarc.jsonc')) then
      return
    end

    -- Apply neovim specific settings
    local runtime_path = vim.split(package.path, ';')
    table.insert(runtime_path, vim.fs.joinpath('lua', '?.lua'))
    table.insert(runtime_path, vim.fs.joinpath('lua', '?', 'init.lua'))

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        -- tell the language server which version of Lua you're using
        version = 'LuaJIT',
        path = runtime_path,
      },
      diagnostics = {
        -- get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        checkThirdParty = false,
        library = {
          -- make the server aware of Neovim runtime files
          vim.env.VIMRUNTIME,
          vim.fn.stdpath('config'),
          -- for vim.uv functions
          '${3rd}/luv/library',
        },
      },
    })
  end
}))

if vim.fn.executable('pyright-langserver') > 0 then
  -- fallback to pyright-langserver for older python versions
  lspconfig.pyright.setup(lsp_defaults)
else
  lspconfig.basedpyright.setup(vim.tbl_deep_extend(
    'force',
    lsp_defaults,
    {
      settings = {
        basedpyright = {
          typeCheckingMode = 'basic',
        },
      },
    }))
end

lspconfig.yamlls.setup(vim.tbl_extend('force', lsp_defaults, { settings = { redhat = { telemetry = { enabled = false }}}}))

local augroup = vim.api.nvim_create_augroup('rkernan.plugins.lspconfig', { clear = true })
vim.api.nvim_create_autocmd('LspAttach', { group = augroup, callback = lsp_attach })
vim.api.nvim_create_autocmd('LspDetach', { group = augroup, callback = lsp_detach })
