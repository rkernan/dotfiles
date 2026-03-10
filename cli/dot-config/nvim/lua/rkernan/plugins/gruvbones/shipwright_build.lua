local lushwright = require('shipwright.transform.lush')
local colorschemes = require('rkernan.plugins.gruvbones.palette')
local specs_name = 'gruvbones'

for _, bg in pairs({'dark', 'light'}) do
  local term = colorschemes[bg].termcolors
  ---@diagnostic disable: undefined-global
  run(
    colorschemes[bg].specs,
    lushwright.to_vimscript,
    function (colors)
      local termcolors = {
        string.format("let g:terminal_color_0 = '%s'", term.black),
        string.format("let g:terminal_color_1 = '%s'", term.red),
        string.format("let g:terminal_color_2 = '%s'", term.green),
        string.format("let g:terminal_color_3 = '%s'", term.yellow),
        string.format("let g:terminal_color_4 = '%s'", term.blue),
        string.format("let g:terminal_color_5 = '%s'", term.magenta),
        string.format("let g:terminal_color_6 = '%s'", term.cyan),
        string.format("let g:terminal_color_7 = '%s'", term.white),
        string.format("let g:terminal_color_8 = '%s'", term.bright_black),
        string.format("let g:terminal_color_9 = '%s'", term.bright_red),
        string.format("let g:terminal_color_10 = '%s'", term.bright_green),
        string.format("let g:terminal_color_11 = '%s'", term.bright_yellow),
        string.format("let g:terminal_color_12 = '%s'", term.bright_blue),
        string.format("let g:terminal_color_13 = '%s'", term.bright_magenta),
        string.format("let g:terminal_color_14 = '%s'", term.bright_cyan),
        string.format("let g:terminal_color_15 = '%s'", term.bright_white),
      }
      return vim.list_extend(termcolors, colors)
    end,
    { prepend, [[" This codeblock is auto-generate by shipwright.nvim ]] },
    {
      function (lines, length)
        local padded_lines = {}
        for _, line in ipairs(lines) do
          line = table.insert(padded_lines, string.rep(" ", length) .. line)
        end
        return padded_lines
      end, 4
    }, {
      patchwrite,
      string.format('%s.vim', specs_name),
      string.format([[" PATCH_OPEN %s]], bg),
      string.format([[" PATCH_CLOSE %s]], bg),
    }
  )
---@diagnostic enable: undefined-global
end
