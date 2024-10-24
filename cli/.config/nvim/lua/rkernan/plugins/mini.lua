-- FIXME helper function?
local function gen_clues(mappings)
  local clues = {}
  for _, mapping in pairs(mappings) do
    table.insert(clues, { mode = mapping.mode, keys = mapping.keys, postkeys = mapping.postkeys })
  end
  return clues
end

return {
  'echasnovski/mini.nvim',
  version = false,
  lazy = false,
  keys = {
    -- mini.files
    { '<Leader>F', function () MiniFiles.open() end, desc = 'File explorer' },
    -- mini.pick
    { '<Leader>f', function () MiniPick.builtin.files() end, desc = 'Files' },
    { '<Leader>b', function () MiniPick.builtin.buffers() end, desc = 'Buffers' },
    { '<Leader>/', function () MiniPick.builtin.grep_live() end, desc = 'Live grep' },
    { '<Leader>e', function () MiniExtra.pickers.diagnostic({ scope = 'current' }) end, desc = 'Diagnostics' },
    { '<Leader>E', function () MiniExtra.pickers.diagnostic({ scope = 'all' }) end, desc = 'Workspace diagnostics' },
  },
  config = function()
    require('mini.ai').setup()
    require('mini.align').setup()

    require('mini.basics').setup({
      options = {
        basic = true,
        extra_ui = true,
        win_borders = 'single',
      },
      mappings = {
        basic = false,
      },
      autocommands = {
        basic = false,
      },
    })

    require('mini.bracketed').setup()

    local minimove_trigger = '<Leader>m'
    local minimove_mappings = {
      left       = { mode = 'n', keys = minimove_trigger .. 'h', postkeys = minimove_trigger },
      down       = { mode = 'n', keys = minimove_trigger .. 'j', postkeys = minimove_trigger },
      up         = { mode = 'n', keys = minimove_trigger .. 'k', postkeys = minimove_trigger },
      right      = { mode = 'n', keys = minimove_trigger .. 'l', postkeys = minimove_trigger },
      line_left  = { mode = 'x', keys = minimove_trigger .. 'h', postkeys = minimove_trigger },
      line_down  = { mode = 'x', keys = minimove_trigger .. 'j', postkeys = minimove_trigger },
      line_up    = { mode = 'x', keys = minimove_trigger .. 'k', postkeys = minimove_trigger },
      line_right = { mode = 'x', keys = minimove_trigger .. 'l', postkeys = minimove_trigger },
    }
    local minimove_clues = gen_clues(minimove_mappings)
    local miniclue = require('mini.clue')

    miniclue.setup({
      triggers = {
        -- Leader triggers
        { mode = 'n', keys = '<Leader>' },
        { mode = 'x', keys = '<Leader>' },
        -- Built-in completion
        { mode = 'i', keys = '<C-x>' },
        -- `g` key
        { mode = 'n', keys = 'g' },
        { mode = 'x', keys = 'g' },
        -- Marks
        { mode = 'n', keys = "'" },
        { mode = 'n', keys = '`' },
        { mode = 'x', keys = "'" },
        { mode = 'x', keys = '`' },
        -- Registers
        { mode = 'n', keys = '"' },
        { mode = 'x', keys = '"' },
        { mode = 'i', keys = '<C-r>' },
        { mode = 'c', keys = '<C-r>' },
        -- Window commands
        { mode = 'n', keys = '<C-w>' },
        -- `z` key
        { mode = 'n', keys = 'z' },
        { mode = 'x', keys = 'z' },
        -- mini.basic
        { mode = 'n', keys = '\\' },
        -- mini.bracketed
        { mode = 'n', keys = ']' },
        { mode = 'x', keys = ']' },
        -- mini.surround
        { mode = 'n', keys = 's' },
        { mode = 'x', keys = 's' },
      },
      clues = {
        miniclue.gen_clues.builtin_completion(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.windows({ submode_move = true, submode_resize = true }),
        miniclue.gen_clues.z(),
        minimove_clues,
        require('rkernan.plugins.dap.keys').clues,
      },
      window = {
        -- delay = 500,
        config = {
          width = 'auto',
        }
      }
    })

    require('mini.comment').setup()
    require('mini.extra').setup()
    require('mini.files').setup()

    local hipatterns = require('mini.hipatterns')
    hipatterns.setup({
      highlighters = {
        -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
        fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
        hack  = { pattern = '%f[%w]()HACK()%f[%W]',  group = 'MiniHipatternsHack'  },
        todo  = { pattern = '%f[%w]()TODO()%f[%W]',  group = 'MiniHipatternsTodo'  },
        note  = { pattern = '%f[%w]()NOTE()%f[%W]',  group = 'MiniHipatternsNote'  },
        -- Highlight hex color strings (`#rrggbb`) using that color
        hex_color = hipatterns.gen_highlighter.hex_color(),
      }
    })

    require('mini.icons').setup()
    MiniIcons.mock_nvim_web_devicons()

    require('mini.jump').setup({
      mappings = {
        repeat_jump = '',
      },
    })

    require('mini.jump2d').setup()

    require('mini.move').setup({
      mappings = {
        left       = minimove_mappings.left.keys,
        down       = minimove_mappings.down.keys,
        up         = minimove_mappings.up.keys,
        right      = minimove_mappings.right.keys,
        line_left  = minimove_mappings.line_left.keys,
        line_down  = minimove_mappings.line_down.keys,
        line_up    = minimove_mappings.line_up.keys,
        line_right = minimove_mappings.line_right.keys,
      },
    })

    require('mini.notify').setup({
      window = {
        config = {
          -- don't draw over winbar
          row = 1,
        },
      },
    })
    MiniNotify.make_notify()

    require('mini.operators').setup()
    require('mini.pairs').setup()

    require('mini.pick').setup()
    vim.ui.select = MiniPick.ui_select

    require('mini.surround').setup()
    require('mini.trailspace').setup()
  end,
}
