local colors_name = 'gruvbones'
local lush = require('lush')
local hsluv = lush.hsluv -- Human-friendly hsl
local term = require('zenbones.term')
local util = require('zenbones.util')

local function gen_specs(palette, bg)
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

  return { specs = specs, termcolors = term.colors_map(palette) }
end

local palette = {
  light = util.palette_extend(
    {
      bg      = hsluv('#fbf1c7'),
      fg      = hsluv('#3c3836'),
      rose    = hsluv('#9d0006'),
      leaf    = hsluv('#79740e'),
      wood    = hsluv('#b57614'),
      water   = hsluv('#076678'),
      blossom = hsluv('#8f3f71'),
      sky     = hsluv('#427b58'),
    },
    'light'),
  dark = util.palette_extend(
    {
      bg      = hsluv('#282828'),
      fg      = hsluv('#ebdbb2'),
      rose    = hsluv('#fb4934'),
      leaf    = hsluv('#b8bb26'),
      wood    = hsluv('#fabd2f'),
      water   = hsluv('#83a598'),
      blossom = hsluv('#d3869b'),
      sky     = hsluv('#83c07c'),
    },
    'dark'),
}

return {
  light = gen_specs(palette.light, 'light'),
  dark = gen_specs(palette.dark, 'dark'),
}
