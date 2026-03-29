local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_deps_path = path_package .. 'pack/deps/start/mini.deps'
if not vim.uv.fs_stat(mini_deps_path) then
  vim.cmd('echo "Installing `mini.deps`" | redraw')
  local clone_cmd = {
    'git', 'clone', '--filter=blob:none',
    'https://github.com/nvim-mini/mini.deps', mini_deps_path
  }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.deps | helptags ALL')
  vim.cmd('echo "Installed `mini.deps`" | redraw')
end

require('mini.deps').setup({ path = { package = path_package } })

---@diagnostic disable: undefined-global
local add = MiniDeps.add
---@diagnostic enable: undefined-global

add({ name = 'mini.deps', checkout = 'stable' })

add({ source = 'mfussenegger/nvim-lint' })
add({ source = 'mrjones2014/smart-splits.nvim' })
add({ source = 'neovim/nvim-lspconfig' })
add({ source = 'nmac427/guess-indent.nvim' })
add({ source = 'nvim-mini/mini.ai', checkout = 'stable' })
add({ source = 'nvim-mini/mini.align', checkout = 'stable' })
add({ source = 'nvim-mini/mini.bracketed', checkout = 'stable' })
add({ source = 'nvim-mini/mini.cmdline', checkout = 'stable' })
add({ source = 'nvim-mini/mini.comment', checkout = 'stable' })
add({ source = 'nvim-mini/mini.completion', checkout = 'stable' })
add({ source = 'nvim-mini/mini.diff', checkout = 'stable' })
add({ source = 'nvim-mini/mini.extra', checkout = 'stable' })
add({ source = 'nvim-mini/mini.hipatterns', checkout = 'stable' })
add({ source = 'nvim-mini/mini.icons', checkout = 'stable' })
add({ source = 'nvim-mini/mini.keymap', checkout = 'stable' })
add({ source = 'nvim-mini/mini.misc', checkout = 'stable' })
add({ source = 'nvim-mini/mini.notify', checkout = 'stable' })
add({ source = 'nvim-mini/mini.operators', checkout = 'stable' })
add({ source = 'nvim-mini/mini.pairs', checkout = 'stable' })
add({ source = 'nvim-mini/mini.pick', checkout = 'stable' })
add({ source = 'nvim-mini/mini.surround', checkout = 'stable' })
add({ source = 'nvim-treesitter/nvim-treesitter', post_checkout = ':TSUpdate' })
add({ source = 'pteroctopus/faster.nvim' })
add({ source = 'stevearc/conform.nvim' })
add({ source = 'stevearc/oil.nvim' })
add({ source = 'yorickpeterse/nvim-pqf' })

require('faster').setup()
require('guess-indent').setup()
require('lint').linters_by_ft = {}
require('oil').setup()

require('conform').setup({
  formatters_by_ft = {
    ['*'] = { 'trim_whitespace' },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_format = 'fallback',
  },
})

require('mini.ai').setup()
require('mini.align').setup()
require('mini.bracketed').setup()
require('mini.comment').setup()
require('mini.completion').setup()
require('mini.cmdline').setup()
require('mini.operators').setup()
require('mini.pairs').setup()
require('mini.pick').setup()
require('mini.surround').setup()
require('mini.diff').setup({ view = { style = 'number' }})
require('mini.notify').setup({ window = { config = { row = 1 }}})
require('mini.icons').setup()
require('mini.icons').tweak_lsp_kind()
local hipatterns = require('mini.hipatterns')
local hi_words = require('mini.extra').gen_highlighter.words
hipatterns.setup({
  highlighters = {
    fixme = hi_words({ 'FIXME', 'fixme' }, 'MiniHipatternsFixme'),
    hack  = hi_words({ 'HACK',  'hack'  }, 'MiniHipatternsHack'),
    todo  = hi_words({ 'TODO',  'todo'  }, 'MiniHipatternsTodo'),
    note  = hi_words({ 'NOTE',  'note'  }, 'MiniHipatternsNote'),
    hex_color = hipatterns.gen_highlighter.hex_color(),
  }
})

local signs = require('rkernan.diagnostic').signs
require('pqf').setup({
  signs = {
    error   = { text = signs[vim.diagnostic.severity.ERROR] },
    warning = { text = signs[vim.diagnostic.severity.WARN]  },
    info    = { text = signs[vim.diagnostic.severity.INFO]  },
    hint    = { text = signs[vim.diagnostic.severity.HINT]  },
  }
})

require('nvim-treesitter').setup({
  auto_install = true,
  highlight = { enable = true },
  indent = { enable = true },
  additional_vim_regex_highlighting = false,
})
