---@diagnostic disable: undefined-global
local add = MiniDeps.add
---@diagnostic enable: undefined-global

add({ source = 'mfussenegger/nvim-lint' })
require('lint').linters_by_ft = {}
