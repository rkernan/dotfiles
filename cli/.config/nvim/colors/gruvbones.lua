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
    sym('@constant.builtin')({ Constant }),

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
    UserLightbulbExt({ zenbones.CursorLine, fg = zenbones.DiagnosticWarn.fg }),

    -- no italic WhichKey
    WhichKey({ zenbones.WhichKey, gui = 'none' }),

    -- statusline
    StatusLineNC({ zenbones.StatusLine, fg = zenbones.StatusLine.fg.da(15) }),

    -- statusline - basic
    StatusLineBlack({ zenbones.StatusLine, fg = zenbones.StatusLine.fg.da(30) }),
    StatusLineBlue({ zenbones.StatusLine, fg = hsluv('#83A598') }),
    StatusLineCyan({ zenbones.StatusLine, fg = hsluv('#82C07B') }),
    StatusLineGreen({ zenbones.StatusLine, fg = hsluv('#B7BA26') }),
    StatusLineMagenta({ zenbones.StatusLine, fg = hsluv('#D2859A') }),
    StatusLineOrange({ zenbones.StatusLine, fg = hsluv('#FF9000') }),
    StatusLineRed({ zenbones.StatusLine, fg = hsluv('#FB4C36') }),
    StatusLineWhite({ zenbones.StatusLine }),
    StatusLineYellow({ zenbones.StatusLine, fg = hsluv('#B7BA26') }),

    -- statusline - mode
    StatusLineModeNormal({ fg = hsluv('#282828'), bg = StatusLineWhite.fg }),
    StatusLineModeCommand({ StatusLineModeNormal, bg = StatusLineGreen.fg }),
    StatusLineModeInsert({ StatusLineModeNormal, bg = StatusLineBlue.fg }),
    StatusLineModeReplace({ StatusLineModeNormal, bg = StatusLineRed.fg }),
    StatusLineModeTerminal({ StatusLineModeNormal, bg = StatusLineYellow.fg }),
    StatusLineModeVisual({ StatusLineModeNormal, bg = StatusLineOrange.fg }),

    -- statusline - diagnostics
    StatusLineDiagnosticError({ zenbones.StatusLine, fg = zenbones.DiagnosticSignError.fg }),
    StatusLineDiagnosticWarn({ zenbones.StatusLine, fg = zenbones.DiagnosticSignWarn.fg }),
    StatusLineDiagnosticHint({ zenbones.StatusLine, fg = zenbones.DiagnosticSignHint.fg }),
    StatusLineDiagnosticInfo({ zenbones.StatusLine, fg = zenbones.DiagnosticSignInfo.fg }),

    -- statusline - git
    StatusLineGitDiffAdd({ zenbones.StatusLine, fg = zenbones.GitSignsAdd.fg }),
    StatusLineGitDiffChange({ zenbones.StatusLine, fg = zenbones.GitSignsChange.fg }),
    StatusLineGitDiffDelete({ zenbones.StatusLine, fg = zenbones.GitSignsDelete.fg }),

    -- winbar
    WinBar({ zenbones.StatusLine }),
    WinBarNC({ StatusLineNC }),

    ---@diagnostic enable: undefined-global
  }
end)

lush(specs)

require("zenbones.term").apply_colors(palette)
