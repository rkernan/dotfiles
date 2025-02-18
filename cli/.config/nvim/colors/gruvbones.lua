local colors_name = 'gruvbones'
vim.g.colors_name = colors_name -- Required when defining a colorscheme

local lush = require('lush')
local hsluv = lush.hsluv -- Human-friendly hsl
local util = require('zenbones.util')

local bg = vim.opt.background:get()

-- Define a palette. Use `palette_extend` to fill unspecified colors
-- Based on https://github.com/gruvbox-community/gruvbox#palette
local palette
if bg == 'light' then
  palette = util.palette_extend({
    bg      = hsluv('#fbf1c7'),
    fg      = hsluv('#3c3836'),
    rose    = hsluv('#9d0006'),
    leaf    = hsluv('#79740e'),
    wood    = hsluv('#b57614'),
    water   = hsluv('#076678'),
    blossom = hsluv('#8f3f71'),
    sky     = hsluv('#427b58'),
  }, bg)
else
  palette = util.palette_extend({
    bg      = hsluv('#282828'),
    fg      = hsluv('#ebdbb2'),
    rose    = hsluv('#fb4934'),
    leaf    = hsluv('#b8bb26'),
    wood    = hsluv('#fabd2f'),
    water   = hsluv('#83a598'),
    blossom = hsluv('#d3869b'),
    sky     = hsluv('#83c07c'),
  }, bg)
end

-- Generate the lush specs using the generator util
local generator = require('zenbones.specs')
local base_specs = generator.generate(palette, bg, generator.get_global_config(colors_name, bg))

local specs = lush.extends({ base_specs }).with(function (injected_functions)
  local sym = injected_functions.sym
  return {
    ---@diagnostic disable: undefined-global

    -- no italic comments
    Comment({ base_specs.Comment, gui = 'none' }),
    sym('@comment')({ Comment }),

    -- no italic constants
    Constant({ base_specs.Constant, gui = 'none' }),
    sym('@constant.builtin')({ Constant }),

    -- no italic tags
    sym('@tag')({ Constant }),

    -- no italic numbers and floats
    Number({ base_specs.Number, gui = 'none' }),
    sym('@number')({ Number }),
    Float({ Number }),
    sym('@float')({ Float }),

    -- sky booleans
    ---@diagnostic disable-next-line: undefined-field
    Boolean({ Constant, fg = palette.sky, gui = 'italic' }),
    sym('@boolean')({ Boolean }),

    -- rose italic statements
    ---@diagnostic disable-next-line: undefined-field
    Statement({ base_specs.Statement, fg = palette.rose, gui = 'italic' }),
    sym('@statement')({ Statement }),

    -- no italic operators
    Operator({ Statement, gui = 'none' }),
    sym('@operator')({ Operator }),

    -- mini.hipatterns - disable gui in text elements
    sym('@text.danger')({ gui = 'none' }),
    sym('@text.note')({ gui = 'none' }),
    sym('@text.todo')({ gui = 'none' }),
    sym('@text.warning')({ gui = 'none' }),

    -- mini.diff - link to GitSigns
    MiniDiffSignAdd({ base_specs.GitSignsAdd }),
    MiniDiffSignChange({ base_specs.GitSignsChange }),
    MiniDiffSignDelete({ base_specs.GitSignsDelete }),

    -- tabnine
    TabnineSuggestion({ fg = base_specs.Normal.fg.da(50), gui = 'italic' }),

    ---@diagnostic enable: undefined-global
  }
end)

-- Pass the specs to lush to apply
lush(specs)

-- Optionally set term colors
require('zenbones.term').apply_colors(palette)
