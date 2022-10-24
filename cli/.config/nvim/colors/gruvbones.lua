local colors_name = 'gruvbones'
-- required when defining a colorscheme
vim.g.colors_name = colors_name

local lush = require('lush')
local hsluv = lush.hsluv
local util = require('zenbones.util')

local bg = vim.opt.background:get()

local palette
if bg == "light" then
  palette = util.palette_extend({
    bg = hsluv('#fbf1c7'),
    fg = hsluv('#3c3836'),
    rose = hsluv('#9d0006'),
    leaf = hsluv('#79740e'),
    wood = hsluv('#b57614'),
    water = hsluv('#076678'),
    blossom = hsluv('#8f3f71'),
    sky = hsluv('#427b58'),
  }, bg)
else
  palette = util.palette_extend({
    bg = hsluv('#282828'),
    fg = hsluv('#ebdbb2'),
    rose = hsluv('#fb4934'),
    leaf = hsluv('#b8bb26'),
    wood = hsluv('#fabd2f'),
    water = hsluv('#83a598'),
    blossom = hsluv('#d3869b'),
    sky = hsluv('#83c07c'),
  }, bg)
end

local generator = require('zenbones.specs')
local zenbones = generator.generate(palette, bg, generator.get_global_config(colors_name, bg))

local specs = lush.extends({ zenbones }).with(function (injected_functions)
  local sym = injected_functions.sym
  return {
    ---@diagnostic disable: undefined-global

    -- no italic comments
    Comment({ zenbones.Comment, gui = 'none' }),
    sym('@comment')({ Comment }),

    -- no italic constants
    Constant({ zenbones.Constant, gui = 'none' }),

    -- no italic tags
    sym('@tag')({ Constant }),

    -- no italic numbers and floats
    Number({ zenbones.Number, gui = 'none' }),
    sym('@number')({ Number }),
    Float({ Number }),
    sym('@float')({ Float }),

    -- sky booleans
    Boolean({ Constant, fg = palette.sky, gui = 'italic' }),
    sym('@boolean')({ Boolean }),

    -- rose italic statements
    Statement({ zenbones.Statement, fg = palette.rose, gui = 'italic' }),
    sym('@statement')({ Statement }),

    -- no italic operators
    Operator({ Statement, gui = 'none' }),
    sym('@operator')({ Operator }),

    -- underline errors, warnings, and hints
    DiagnosticUnderlineError({ zenbones.DiagnosticUnderlineError, gui = 'underline' }),
    DiagnosticUnderlineWarn({  zenbones.DiagnosticUnderlineWarn,  gui = 'underline' }),
    DiagnosticUnderlineHint({  zenbones.DiagnosticUnderlineHint,  gui = 'underline' }),

    -- no uderline on info
    DiagnosticUnderlineInfo({ zenbones.DiagnosticUnderlineInfo,  gui = 'none' }),

    -- lightbulb highlights
    LightBulbFloatWin({ zenbones.Float, fg = zenbones.DiagnosticWarn.fg }),
    LightbulbVirtualText({ zenbones.CursorLine, fg = zenbones.DiagnosticWarn.fg }),

    ---@diagnostic enable: undefined-global
  }
end)

lush(specs)

require("zenbones.term").apply_colors(palette)
