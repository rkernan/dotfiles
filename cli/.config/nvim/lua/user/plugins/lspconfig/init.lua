local function lsp_attach(args)
  local client = vim.lsp.get_client_by_id(args.data.client_id)
  if not client then
    return
  end

  local bufnr = args.buf

  if client.server_capabilities.signatureHelpProvider then
    vim.keymap.set('n', 'K', vim.lsp.buf.signature_help, { buffer = bufnr, desc = 'LSP signature help' })
    vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, { buffer = bufnr, desc = 'LSP signature help' })
  end

  if client.server_capabilities.definitionProvider then
    vim.keymap.set('n', '<Leader><Leader>d', vim.lsp.buf.definition, { buffer = bufnr, desc = 'LSP definition' })
  end

  if client.server_capabilities.declarationProvider then
    vim.keymap.set('n', '<Leader><Leader>D', vim.lsp.buf.declaration, { buffer = bufnr, desc = 'LSP declaration' })
  end

  if client.server_capabilities.typeDefinitionProvider then
    vim.keymap.set('n', '<Leader><Leader>t', vim.lsp.buf.type_definition, { buffer = bufnr, desc = 'LSP type definition'} )
  end

  if client.server_capabilities.documentFormattingProvider then
    vim.keymap.set('n', '<Leader><Leader>f', vim.lsp.buf.format, { buffer = bufnr, desc = 'LSP format buffer' })
  end

  if client.server_capabilities.documentRangeFormattingProvider then
    vim.keymap.set('x', '<Leader><Leader>f', vim.lsp.buf.format, { buffer = bufnr, desc = 'LSP format buffer' })
  end

  if client.server_capabilities.renameProvider then
    vim.keymap.set('n', '<Leader><Leader>R', vim.lsp.buf.rename, { buffer = bufnr, desc = 'LSP rename' })
  end

  if client.server_capabilities.codeActionProvider then
    vim.keymap.set('n', '<Leader><Leader>A', vim.lsp.buf.code_action, { buffer = bufnr, desc = 'LSP code actions' })
  end

  if client.server_capabilities.inlayHintProvider then
    vim.keymap.set('n', '<Leader><Leader>I', function ()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end, { buffer = bufnr, desc = 'LSP toggle inlay hints' })
  end

  if client.server_capabilities.documentSymbolProvider then
    require('nvim-navic').attach(client, bufnr)
  end
end

local function lsp_detach(args)
  local bufnr = args.buf
  pcall(vim.keymap.del, 'n', 'K', { buffer = bufnr})
  pcall(vim.keymap.del, 'i', '<C-k>', { buffer = bufnr})
  pcall(vim.keymap.del, 'n', '<Leader><Leader>d', { buffer = bufnr})
  pcall(vim.keymap.del, 'n', '<Leader><Leader>D', { buffer = bufnr})
  pcall(vim.keymap.del, 'n', '<Leader><Leader>t', { buffer = bufnr})
  pcall(vim.keymap.del, 'n', '<Leader><Leader>f', { buffer = bufnr})
  pcall(vim.keymap.del, 'x', '<Leader><Leader>f', { buffer = bufnr})
  pcall(vim.keymap.del, 'n', '<Leader><Leader>R', { buffer = bufnr})
  pcall(vim.keymap.del, 'n', '<Leader><Leader>A', { buffer = bufnr})
  pcall(vim.keymap.del, 'n', '<Leader><Leader>I', { buffer = bufnr})
end

return {
  'neovim/nvim-lspconfig',
  dependencies = {
    -- completion
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'hrsh7th/cmp-nvim-lsp-document-symbol',
    -- statusline breadcrumbs
    'SmiteshP/nvim-navic',
  },
  lazy = false,
  config = function()
    local lspconfig = require('lspconfig')
    local capabilities = require('user.plugins.lspconfig.capabilities')

    local handlers = {
      ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'single' }),
      ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'single' }),
    }

    lspconfig.bashls.setup({ capabilities = capabilities, handlers = handlers })
    lspconfig.basedpyright.setup({
      capabilities = capabilities,
      handlers = handlers,
      settings = {
        basedpyright = {
          typeCheckingMode = 'basic',
        },
      },
    })
    lspconfig.gopls.setup({ capabilities = capabilities, handlers = handlers })
    lspconfig.jsonls.setup({ capabilities = capabilities, handlers = handlers })
    lspconfig.lua_ls.setup({ capabilities = capabilities, handlers = handlers })
    lspconfig.pyright.setup({ capabilities = capabilities, handlers = handlers })

    local cmp = require('cmp')

    local kind_icons = {
      Text = "",
      Method = "󰆧",
      Function = "󰊕",
      Constructor = "",
      Field = "󰇽",
      Variable = "󰂡",
      Class = "󰠱",
      Interface = "",
      Module = "",
      Property = "󰜢",
      Unit = "",
      Value = "󰎠",
      Enum = "",
      Keyword = "󰌋",
      Snippet = "",
      Color = "󰏘",
      File = "󰈙",
      Reference = "",
      Folder = "󰉋",
      EnumMember = "",
      Constant = "󰏿",
      Struct = "",
      Event = "",
      Operator = "󰆕",
      TypeParameter = "󰅲",
    }

    cmp.setup({
      enabled = function ()
        local context = require('cmp.config.context')
        -- always enable command mode completion
        if vim.api.nvim_get_mode().mode == 'c' then
          return true
        else
          -- disable completion in comments
          return not context.in_treesitter_capture('comment') and
            not context.in_syntax_group('comment')
        end
      end,
      formatting = {
        format = function (entry, vim_item)
          vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
          return vim_item
        end,
      },
      snippet = {
        expand = function (args)
          vim.snippet.expand(args.body)
        end
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        ['<Tab>']   = cmp.mapping(function (fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif vim.snippet.active({ direction = 1 }) then
            vim.snippet.jump(1)
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function (fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif vim.snippet.active({ direction = -1 }) then
            vim.snippet.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' },
      }, {
        { name = 'buffer' },
      })
    })

    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      source = cmp.config.sources({
        { name = 'nvim_lsp_document_symbols' },
      }, {
        { name = 'buffer' },
      }),
    })

    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' },
      }, {
        { name = 'cmdline' },
      }),
      matching = { disallow_symbol_nonprefix_matching = false },
    })

    local augroup = vim.api.nvim_create_augroup('user.plugins.lspconfig', { clear = true })
    vim.api.nvim_create_autocmd('LspAttach', { group = augroup, callback = lsp_attach })
    vim.api.nvim_create_autocmd('LspDetach', { group = augroup, callback = lsp_detach })
  end,
}
