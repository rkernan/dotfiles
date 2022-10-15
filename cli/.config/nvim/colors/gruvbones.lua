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
local base_specs = generator.generate(palette, bg, generator.get_global_config(colors_name, bg))

local specs = lush.extends({ base_specs }).with(function ()
  return {
    -- no italic comments
    Comment({ base_specs.Comment, gui = 'none' }),
    -- no italic numbers
    Number({ base_specs.Number, gui = 'none' }),
    Float({ base_specs.Float, gui = 'none' }),
    Boolean({ base_specs.Boolean, fg = palette.sky, gui = 'none' }),
    -- rose statements, no italic operators
    Statement({ base_specs.Statement, fg = palette.rose, gui = 'italic' }),
    Operator({ base_specs.Statement, fg = palette.rose, gui = 'none' }),
    -- water specials
    Special({ fg = palette.water }),
    -- no italic strings
    String({ base_specs.Constant, gui = 'none' }),
    -- underline errors
    DiagnosticUnderlineError({ base_specs.DiagnosticUnderlineError, gui = 'underline' }),
    DiagnosticUnderlineWarn({ base_specs.DiagnosticUnderlineWarn, gui = 'underline' }),
    DiagnosticUnderlineHint({ base_specs.DiagnosticUnderlineHint, gui = 'underline' }),
    DiagnosticUnderlineInfo({ base_specs.DiagnosticUnderlineInfo, gui = 'underline' }),
  }
end)

lush(specs)

require("zenbones.term").apply_colors(palette)
