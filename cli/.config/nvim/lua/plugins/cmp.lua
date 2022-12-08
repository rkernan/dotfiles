local cmp = require('cmp')
local luasnip = require('luasnip')
local kind_icons = require('plugins.lsp.kind').icons

cmp.event:on('confirm_done', require('nvim-autopairs.completion.cmp').on_confirm_done())

cmp.setup({
  enabled = function ()
    -- disable completion in comments
    if vim.api.nvim_get_mode().mode == 'c' then
      -- keep command mode completion when cursor is in comment
      return true
    else
      local context = require('cmp.config.context')
      return not context.in_treesitter_capture('comment') and not context.in_syntax_group('Comment')
    end
  end,
  formatting = {
    format = function (entry, vim_item)
      -- kind icons
      vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
      -- kind icons - force File icon for path
      if entry.source.name == 'path' then
        vim_item.kind = string.format('%s %s', kind_icons['File'], 'File')
      end

      return vim_item
    end
  },
  snippet = {
    expand = function (args)
      luasnip.lsp_expand(args.body)
    end
  },
  mapping = {
    ['<c-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4),  { 'i', 'c' }),
    ['<c-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<c-space>'] = cmp.mapping(cmp.mapping.complete({}), { 'i', 'c' }),
    ['<c-e'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<cr>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    }),
    ['<tab>'] = cmp.mapping(function (fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 'c' }),
    ['<s-tab>'] = cmp.mapping(function (fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 'c' }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip'},
    { name = 'nvim_lsp_signature_help' },
  }, {
    { name = 'buffer' },
  })
})

cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' },
  }
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' },
  }, {
    { name = 'cmdline' },
  })
})
