local add, later = MiniDeps.add, MiniDeps.later

local function try_lint()
  require('lint').try_lint()
  -- always check spelling
  -- require('lint').try_lint('cspell')
end

add({ source = 'mfussenegger/nvim-lint' })
later(function ()
  local lint = require('lint')
    lint.linters_by_ft = {
      python = {
        'pycodestyle',
        'pydocstyle',
      },
    }

    lint.linters.cspell = require("lint.util").wrap(lint.linters.cspell, function(diagnostic)
      diagnostic.severity = vim.diagnostic.severity.HINT
      return diagnostic
    end)

    -- FIXME augroup
    vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufWritePost' }, { callback = try_lint })
end)
