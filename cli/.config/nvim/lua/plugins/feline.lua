local feline = require('feline') local vi_mode =
require('feline.providers.vi_mode')

local function get_theme()
  local palette = require('gruvbox.palette')
  return {
    fg = palette.light4,
    bg = palette.dark2,
    aqua = palette.bright_aqua,
    black = palette.dark0,
    green = palette.bright_green,
    blue = palette.bright_blue,
    orange = palette.bright_orange,
    purple = palette.bright_purple,
    red = palette.bright_red,
    white = palette.light0,
    yellow = palette.bright_yellow,
  }
end

local theme = get_theme()

local vi_mode_text = {
  ['n']     = 'NORMAL',
  ['no']    = 'O-PENDING',
  ['nov']   = 'O-PENDING',
  ['noV']   = 'O-PENDING',
  ['no\22'] = 'O-PENDING',
  ['niI']   = 'NORMAL',
  ['niR']   = 'NORMAL',
  ['niV']   = 'NORMAL',
  ['nt']    = 'NORMAL',
  ['ntT']   = 'NORMAL',
  ['v']     = 'VISUAL',
  ['vs']    = 'VISUAL',
  ['V']     = 'V-LINE',
  ['Vs']    = 'V-LINE',
  ['\22']   = 'V-BLOCK',
  ['\22s']  = 'V-BLOCK',
  ['s']     = 'SELECT',
  ['S']     = 'S-LINE',
  ['\19']   = 'S-BLOCK',
  ['i']     = 'INSERT',
  ['ic']    = 'INSERT',
  ['ix']    = 'INSERT',
  ['R']     = 'REPLACE',
  ['Rc']    = 'REPLACE',
  ['Rx']    = 'REPLACE',
  ['Rv']    = 'V-REPLACE',
  ['Rvc']   = 'V-REPLACE',
  ['Rvx']   = 'V-REPLACE',
  ['c']     = 'COMMAND',
  ['cv']    = 'EX',
  ['ce']    = 'EX',
  ['r']     = 'REPLACE',
  ['rm']    = 'MORE',
  ['r?']    = 'CONFIRM',
  ['!']     = 'SHELL',
  ['t']     = 'TERMINAL',
}

local vi_mode_colors = {
  ['NORMAL'] = 'white',
  ['COMMAND'] = 'green',
  ['INSERT'] = 'blue',
  ['REPLACE'] = 'red',
  ['LINES'] = 'orange',
  ['VISUAL'] = 'orange',
  ['OP'] = 'yellow',
  ['BLOCK'] = 'yellow',
  ['V-REPLACE'] = 'yellow',
  ['ENTER'] = 'yellow',
  ['MORE'] = 'yellow',
  ['SELECT'] = 'yellow',
  ['SHELL'] = 'yellow',
  ['TERM'] = 'yellow',
  ['NONE'] = 'yellow',
}

local components = {
  file = {
    encoding = {
      provider = function ()
        if string.lower(vim.bo.fileencoding) ~= 'utf-8' then
          return vim.bo.fileencoding
        end
        return ''
      end,
      left_sep = ' ',
    },
    format = {
      provider = function ()
        if string.lower(vim.bo.fileformat) ~= 'unix' then
          return vim.bo.fileformat
        end
        return ''
      end,
      left_sep = ' ',
    },
    info = {
      provider = {
        name = 'file_info',
        opts = {
          colored_icon = false,
          file_modified_icon = '+',
          file_readonly_icon = ' ',
          type = 'relative',
        },
      },
      left_sep = '  ',
      hl = { fg = theme.white },
    },
    position = {
      provider = {
        name = 'position',
        opts = {
          padding = true,
        }
      },
      icon = ' ',
      left_sep = ' ',
    },
    position_percent = {
      provider = 'line_percentage',
    },
  },
  git = {
    branch = {
      provider = 'git_branch',
      icon = ' ',
      left_sep = '  ',
      hl = { fg = theme.purple },
    },
    diff_added = {
      provider = 'git_diff_added',
      icon = '+',
      left_sep = ' ',
      hl = { fg = theme.green },
    },
    diff_changed = {
      provider = 'git_diff_changed',
      icon = '~',
      left_sep = ' ',
      hl = { fg = theme.aqua },
    },
    diff_removed = {
      provider = 'git_diff_removed',
      icon = '-',
      left_sep = ' ',
      hl = { fg = theme.red },
    },
  },
  lsp = {
    diagnostics = {
      err  = {
        provider = 'diagnostic_errors',
        icon = ' ',
        left_sep = ' ',
        hl = { fg = theme.red },
      },
      warn = {
        provider = 'diagnostic_warnings',
        icon = ' ',
        left_sep = ' ',
        hl = { fg = theme.yellow },
      },
      hint = {
        provider = 'diagnostic_hints',
        icon = ' ',
        left_sep = ' ',
        hl = { fg = theme.aqua },
      },
      info = {
        provider = 'diagnostic_info',
        icon = ' ',
        left_sep = ' ',
        hl = { fg = theme.white },
      },
    },
    name = {
      provider = 'lsp_client_names',
      left_sep = '  ',
    },
  },
  vi_mode = {
    provider = function () return ' ' .. vi_mode_text[vim.fn.mode()]:sub(1, 1) .. ' ' end,
    hl = function ()
      return {
        name = vi_mode.get_mode_highlight_name(),
        fg = theme.black,
        bg = vi_mode.get_mode_color(),
      }
    end,
  },
}

vim.o.laststatus = 3

feline.setup({
  components = {
    active= {
      {
        components.vi_mode,
        components.file.info,
        components.file.format,
        components.file.encoding,
        components.git.branch,
        components.git.diff_added,
        components.git.diff_changed,
        components.git.diff_removed,
        components.lsp.name,
        components.lsp.diagnostics.err,
        components.lsp.diagnostics.warn,
        components.lsp.diagnostics.info,
        components.lsp.diagnostics.hint,
      }
    },
  },
  theme = theme,
  vi_mode_colors = vi_mode_colors,
  force_inactive = {},
})

feline.winbar.setup({
  components = {
    active = {
      {
        components.file.position_percent,
        components.file.position,
        components.file.info,
      }
    },
    inactive = {
      {
        components.file.position_percent,
        components.file.position,
        components.file.info,
      }
    }
  },
  theme = theme,
  force_inactive = {},
})
