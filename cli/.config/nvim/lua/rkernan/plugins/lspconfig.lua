local function lsp_attach(args)
  local client = vim.lsp.get_client_by_id(args.data.client_id)
  if not client then
    return
  end

  local bufnr = args.buf
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, desc = 'LSP hover' })
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, desc = 'LSP definition' })
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = bufnr, desc = 'LSP declaration' })
  -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = bufnr, desc = 'LSP implementation' })
  vim.keymap.set('n', 'gi', function () MiniExtra.pickers.lsp({ scope = 'implementation' }) end, { buffer = bufnr, desc = 'LSP implementation' })
  vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, { buffer = bufnr, desc = 'LSP definition' })
  -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = bufnr, desc = 'LSP references' })
  vim.keymap.set('n', 'gr', function () MiniExtra.pickers.lsp({ scope = 'references' }) end, { buffer = bufnr, desc = 'LSP references' })
  vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, { buffer = bufnr, desc = 'LSP signature help' })
  vim.keymap.set('n', '<Leader><Leader>rn', vim.lsp.buf.rename, { buffer = bufnr, desc = 'LSP buffer rename' })
  vim.keymap.set({'n', 'x'}, '<Leader><Leader>f', function () vim.lsp.buf.format({async = true}) end, { buffer = bufnr, desc = 'LSP format' })
  vim.keymap.set('n', '<Leader><Leader>ca', vim.lsp.buf.code_action, { buffer = bufnr, desc = 'LSP code action' })

  -- symbols
  vim.keymap.set('n', '<Leader><Leader>o', function () MiniExtra.pickers.lsp({ scope = 'document_symbol' }) end, { buffer = bufnr, desc = 'LSP document symbols' })
  vim.keymap.set('n', '<Leader><Leader>O', function () MiniExtra.pickers.lsp({ scope = 'workspace_symbol' }) end, { buffer = bufnr, desc = 'LSP workspace symbols' })

  -- toggle inlay hints
  vim.keymap.set('n', '<Leader><Leader>i',
    function () vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end,
    { buffer = bufnr, desc = 'LSP toggle inlay hints'}
  )

  -- setup navic
  require('nvim-navic').attach(client, bufnr)
end

local function lsp_detach(args)
  local bufnr = args.buf
  pcall(vim.keymap.del, 'n', 'K', { buffer = bufnr })
  pcall(vim.keymap.del, 'n', 'gd', { buffer = bufnr })
  pcall(vim.keymap.del, 'n', 'gD', { buffer = bufnr })
  pcall(vim.keymap.del, 'n', 'gi', { buffer = bufnr })
  pcall(vim.keymap.del, 'n', 'go', { buffer = bufnr })
  pcall(vim.keymap.del, 'n', 'gr', { buffer = bufnr })
  pcall(vim.keymap.del, 'n', 'gs', { buffer = bufnr })
  pcall(vim.keymap.del, 'n', '<Leader><Leader>rn', { buffer = bufnr })
  pcall(vim.keymap.del, {'n', 'x'}, '<Leader><Leader>f', { buffer = bufnr })
  pcall(vim.keymap.del, 'n', '<Leader><Leader>ca', { buffer = bufnr })
  pcall(vim.keymap.del, 'n', '<Leader><Leader>o', { buffer = bufnr })
  pcall(vim.keymap.del, 'n', '<Leader><Leader>O', { buffer = bufnr })
  pcall(vim.keymap.del, 'n', '<Leader><Leader>i', { buffer = bufnr })
end

return {
  -- neovim completion
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = 'luvit-meta/library', words = { 'vim%.uv' }},
      },
    },
  }, {
    'Bilal2453/luvit-meta',
    lazy = true,
  },

  -- statusline breadcrumbs
  {
    'SmiteshP/nvim-navic',
    lazy = true,
  },

  -- autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = { 'InsertEnter', 'CmdlineEnter' },
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-nvim-lsp-document-symbol',
    },
    config = function()
      local cmp = require('cmp')
      local cmp_action = require('lsp-zero').cmp_action()

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
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
        }, {
          { name = 'buffer' },
        }),
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<Tab>'] = cmp.mapping(function (fallback)
            if not cmp.select_next_item() then
              if vim.snippet.active({ direction = 1 }) then
                vim.snippet.jump(1)
              else
                fallback()
              end
            end
          end),
          ['<S-Tab>'] = cmp.mapping(function (fallback)
            if not cmp.select_prev_item() then
              if vim.snippet.active({ direction = -1 }) then
                vim.snippet.jump(-1)
              else
                fallback()
              end
            end
          end),
        }),
        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body)
          end,
        },
        window = {
          documentation = cmp.config.window.bordered(),
        },
        formatting = {
          expandable_indicator = true,
          fields = { 'abbr', 'kind', 'menu' },
          format = function (_, vim_item)
            vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
            return vim_item
          end,
        },
      })

      cmp.setup.cmdline({'/', '?'}, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'nvim_lsp_document_symbols' },
        }, {
          { name = 'buffer' },
        }),
      })

      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline({
          ['<C-n>'] = cmp.config.disable,
          ['<C-p>'] = cmp.config.disable,
        }),
        sources = cmp.config.sources({
          { name = 'path' },
        }, {
          { name = 'cmdline' },
        }),
      })
    end
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      local lspconfig = require('lspconfig')
      local lsp_defaults = {
        capabilities = vim.tbl_deep_extend('force', lspconfig.util.default_config.capabilities, require('cmp_nvim_lsp').default_capabilities()),
        handlers = {
          ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'single' }),
        },
      }

      lspconfig.bashls.setup(lsp_defaults)
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
      lspconfig.gopls.setup(lsp_defaults)
      lspconfig.jsonls.setup(lsp_defaults)
      lspconfig.lua_ls.setup(lsp_defaults)
      -- fallback for older python versions
      lspconfig.pyright.setup(lsp_defaults)

      local augroup = vim.api.nvim_create_augroup('rkernan.plugins.lspconfig', { clear = true })
      vim.api.nvim_create_autocmd('LspAttach', { group = augroup, callback = lsp_attach })
      vim.api.nvim_create_autocmd('LspDetach', { group = augroup, callback = lsp_detach })
    end
  }
}
