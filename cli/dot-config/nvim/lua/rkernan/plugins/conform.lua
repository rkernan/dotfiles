return {
  src = 'https://github.com/stevearc/conform.nvim.git',
  data = {
    config = function()
      local formatters_by_ft = {
        go = { 'goimports', 'gofmt' },
        json = { 'prettier' },
        just = { 'just' },
        lua = { 'stylua' },
        markdown = { 'prettier' },
        python = { 'isort', 'black' },
        yaml = { 'prettier' },
      }

      require('conform').setup({
        formatters_by_ft = vim.tbl_extend('force', { ['*'] = { 'trim_whitespace' } }, formatters_by_ft),
        format_on_save = {
          timeout_ms = 500,
          lsp_format = 'fallback',
        },
      })

      local augroup = vim.api.nvim_create_augroup('rkernan.plugins.conform', { clear = true })
      vim.api.nvim_create_autocmd('FileType', {
        group = augroup,
        pattern = vim.tbl_keys(formatters_by_ft),
        callback = function()
          vim.bo.formatexpr = "v:lua.require'conform'.formatexpr()"
        end,
      })
    end,
  },
}
