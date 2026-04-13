vim.pack.add({
  'https://github.com/NMAC427/guess-indent.nvim.git',
  'https://github.com/igorlfs/nvim-dap-view.git',
  'https://github.com/mfussenegger/nvim-dap.git',
  'https://github.com/mfussenegger/nvim-lint.git',
  'https://github.com/neovim/nvim-lspconfig.git',
  'https://github.com/nvim-mini/mini.ai.git',
  'https://github.com/nvim-mini/mini.align.git',
  'https://github.com/nvim-mini/mini.bracketed.git',
  'https://github.com/nvim-mini/mini.cmdline.git',
  'https://github.com/nvim-mini/mini.comment.git',
  'https://github.com/nvim-mini/mini.completion.git',
  'https://github.com/nvim-mini/mini.diff.git',
  'https://github.com/nvim-mini/mini.extra.git',
  'https://github.com/nvim-mini/mini.hipatterns.git',
  'https://github.com/nvim-mini/mini.icons.git',
  'https://github.com/nvim-mini/mini.keymap.git',
  'https://github.com/nvim-mini/mini.misc.git',
  'https://github.com/nvim-mini/mini.notify.git',
  'https://github.com/nvim-mini/mini.operators.git',
  'https://github.com/nvim-mini/mini.pairs.git',
  'https://github.com/nvim-mini/mini.surround.git',
  'https://github.com/pteroctopus/faster.nvim.git',
  'https://github.com/romus204/tree-sitter-manager.nvim.git',
  'https://github.com/stevearc/conform.nvim.git',
  'https://github.com/stevearc/oil.nvim.git',
  'https://github.com/yorickpeterse/nvim-pqf.git',
})

require('faster').setup()

require('guess-indent').setup({
  disable_on_editorconfig = true,
})

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

require('dap-view').setup({ winbar = { controls = { enabled = true } } })

require('mini.ai').setup()
require('mini.align').setup()
require('mini.bracketed').setup()
require('mini.comment').setup()
require('mini.completion').setup()
require('mini.cmdline').setup()
require('mini.operators').setup()
require('mini.pairs').setup()
require('mini.surround').setup()
require('mini.diff').setup({ view = { style = 'number' } })
require('mini.notify').setup({ window = { config = { row = 1 } } })
require('mini.icons').setup()
require('mini.icons').tweak_lsp_kind()
local hipatterns = require('mini.hipatterns')
local hi_words = require('mini.extra').gen_highlighter.words
hipatterns.setup({
  highlighters = {
    fixme = hi_words({ 'FIXME', 'fixme' }, 'MiniHipatternsFixme'),
    hack = hi_words({ 'HACK', 'hack' }, 'MiniHipatternsHack'),
    todo = hi_words({ 'TODO', 'todo' }, 'MiniHipatternsTodo'),
    note = hi_words({ 'NOTE', 'note' }, 'MiniHipatternsNote'),
    hex_color = hipatterns.gen_highlighter.hex_color(),
  },
})

local signs = require('rkernan.diagnostic').signs
require('pqf').setup({
  signs = {
    error = { text = signs[vim.diagnostic.severity.ERROR] },
    warning = { text = signs[vim.diagnostic.severity.WARN] },
    info = { text = signs[vim.diagnostic.severity.INFO] },
    hint = { text = signs[vim.diagnostic.severity.HINT] },
  },
})

require('tree-sitter-manager').setup({
  ensure_installed = {
    'bash',
    'c',
    'cmake',
    'cpp',
    'diff',
    'dockerfile',
    'editorconfig',
    'fish',
    'git_config',
    'git_rebase',
    'gitattributes',
    'gitcommit',
    'gitignore',
    'go',
    'groovy',
    'java',
    'javadoc',
    'jinja',
    'jinja_inline',
    'json',
    'lua',
    'make',
    'markdown',
    'markdown_inline',
    'python',
    'rust',
    'ssh_config',
    'tmux',
    'toml',
    'vim',
    'vimdoc',
    'yaml',
  },
})
