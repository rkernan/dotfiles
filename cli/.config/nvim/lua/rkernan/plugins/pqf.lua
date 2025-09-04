---@diagnostic disable: undefined-global
local add = MiniDeps.add
---@diagnostic enable: undefined-global

add({ source = 'yorickpeterse/nvim-pqf' })

local signs = require('rkernan.diagnostic').signs
require('pqf').setup({
  signs = {
    error   = { text = signs[vim.diagnostic.severity.ERROR] },
    warning = { text = signs[vim.diagnostic.severity.WARN]  },
    info    = { text = signs[vim.diagnostic.severity.INFO]  },
    hint    = { text = signs[vim.diagnostic.severity.HINT]  },
  }
})
