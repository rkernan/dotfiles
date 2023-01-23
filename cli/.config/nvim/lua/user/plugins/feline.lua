local hl = require('user.utils.hl')

local function get_theme()
  return {
    fg = hl.get_hl('StatusLine').fg,
    bg = hl.get_hl('StatusLine').bg,
    -- colors
    white = hl.get_hl('StatusLineWhite').fg,
    white2 = hl.get_hl('StatusLineWhite2').fg,
    white3 = hl.get_hl('StatusLineWhite3').fg,
    red = hl.get_hl('StatusLineRed').fg,
    orange = hl.get_hl('StatusLineOrange').fg,
    yellow = hl.get_hl('StatusLineYellow').fg,
    green = hl.get_hl('StatusLineGreen').fg,
    blue = hl.get_hl('StatusLineBlue').fg,
    magenta = hl.get_hl('StatusLineMagenta').fg,
    cyan = hl.get_hl('StatusLineCyan').fg,
    -- mode colors
    mode_normal = hl.get_hl('StatusLineModeNormal').bg,
    mode_insert = hl.get_hl('StatusLineModeInsert').bg,
    mode_command = hl.get_hl('StatusLineModeCommand').bg,
    mode_replace = hl.get_hl('StatusLineModeReplace').bg,
    mode_visual = hl.get_hl('StatusLineModeVisual').bg,
    mode_terminal = hl.get_hl('StatusLineModeTerminal').bg,
    -- diagnostic colors
    diagnostic_errors = hl.get_hl('StatusLineDiagnosticError').fg,
    diagnostic_warnings = hl.get_hl('StatusLineDiagnosticWarn').fg,
    diagnostic_hints = hl.get_hl('StatusLineDiagnosticHint').fg,
    diagnostic_info = hl.get_hl('StatusLineDiagnosticInfo').fg,
    -- gitsigns colors
    git_diff_added = hl.get_hl('StatusLineGitDiffAdd').fg,
    git_diff_changed = hl.get_hl('StatusLineGitDiffChange').fg,
    git_diff_removed = hl.get_hl('StatusLineGitDiffDelete').fg,
  }
end

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
  ['NORMAL'] = 'mode_normal',
  ['COMMAND'] = 'mode_command',
  ['INSERT'] = 'mode_insert',
  ['REPLACE'] = 'mode_replace',
  ['LINES'] = 'mode_visual',
  ['VISUAL'] = 'mode_visual',
  ['OP'] = 'mode_replace',
  ['BLOCK'] = 'mode_visual',
  ['V-REPLACE'] = 'mode_replace',
  ['ENTER'] = 'mode_normal',
  ['MORE'] = 'mode_normal',
  ['SELECT'] = 'mode_replace',
  ['SHELL'] = 'mode_terminal',
  ['TERM'] = 'mode_terminal',
  ['NONE'] = 'mode_normal',
}

local separators = {
  hard = { str = ' │ ', hl = { fg = 'white3' }},
  soft = { str = ' ' },
  arrow = { str = ' > ', hl = { fg = 'white2' }},
}

local components = {
  buffer = {
    is_active = {
      provider = ' ● ',
      hl = { fg = 'green' },
    },
    is_inactive = {
      provider = ' ● ',
      hl = { fg = 'white2' },
    },
  },
  cwd = {
    provider = function ()
      return vim.fn.fnamemodify(vim.fn.getcwd(), ':~')
    end
  },
  git = {
    branch = {
      provider = function ()
        return vim.g.gitsigns_head or ''
      end,
      icon = ' ',
      hl = { fg = 'magenta' },
    },
    diff_added = {
      provider = 'git_diff_added',
      icon = '+',
      hl = { fg = 'git_diff_added' },
    },
    diff_changed = {
      provider = 'git_diff_changed',
      icon = '~',
      hl = { fg = 'git_diff_changed' },
    },
    diff_removed = {
      provider = 'git_diff_removed',
      icon = '-',
      hl = { fg = 'git_diff_removed' },
    },
  },
  file = {
    encoding = {
      provider = function ()
        return vim.bo.fileencoding
      end,
      hl = { fg = 'white2' },
    },
    format = {
      provider = function ()
        return vim.bo.fileformat
      end,
      hl = { fg = 'white2' },
    },
    info = {
      provider = {
        name = 'file_info',
        opts = {
          colored_icon = false,
          file_modified_icon = '[+]',
          file_readonly_icon = ' ',
          type = 'relative',
        },
      },
      hl = { fg = 'white' },
    },
    position = {
      provider = {
        name = 'position',
        opts = {
          padding = true,
        }
      },
      icon = ' ',
    },
    position_percent = {
      provider = 'line_percentage',
    },
    tabs = {
      provider = function ()
        if vim.bo.expandtab then
          return string.format('tab:%d,et', vim.bo.shiftwidth)
        end
        return string.format('tab:%d', vim.bo.shiftwidth)
      end,
      hl = { fg = 'white2' },
    }
  },
  lsp = {
    diagnostics = {
      err  = {
        provider = 'diagnostic_errors',
        icon = ' ',
        hl = { fg = 'diagnostic_errors' },
      },
      warn = {
        provider = 'diagnostic_warnings',
        icon = ' ',
        hl = { fg = 'diagnostic_warnings' },
      },
      hint = {
        provider = 'diagnostic_hints',
        icon = ' ',
        hl = { fg = 'diagnostic_hints' },
      },
      info = {
        provider = 'diagnostic_info',
        icon = ' ',
        hl = { fg = 'diagnostic_info' },
      },
    },
    symbols = {
      provider = function ()
        local navic = require('nvim-navic')
        if navic.is_available() then
          return navic.get_location()
        end
        return ''
      end,
      hl = { fg = 'white2' },
    }
  },
  noice = {
    mode = {
      provider = function ()
        if require('noice').api.status.mode.has() then
          return require('noice').api.status.mode.get()
        end
        return ''
      end,
      icon = '',
      hl = { fg = 'yellow' },
    },
    search = {
      provider = function ()
        if require('noice').api.status.search.has() then
          return require('noice').api.status.search.get()
        end
        return ''
      end,
      icon = '',
      hl = { fg = 'blue' },
    },
  },
  vi_mode = {
    provider = function ()
      return string.format(' %s ', vi_mode_text[vim.fn.mode()]:sub(1, 1))
    end,
    hl = function ()
      return {
        name = require('feline.providers.vi_mode').get_mode_highlight_name(),
        fg = 'bg',
        bg = require('feline.providers.vi_mode').get_mode_color(),
      }
    end,
  },
}

local function wrap_left(cmp, sep)
  local wrap = {}
  for key, val in pairs(cmp) do
    wrap[key] = val
  end
  wrap.left_sep = sep or separators.soft
  return wrap
end

local function wrap_right(cmp, sep)
  local wrap = {}
  for key, val in pairs(cmp) do
    wrap[key] = val
  end
  wrap.right_sep = sep or separators.soft
  return wrap
end

return {
  'feline-nvim/feline.nvim',
  event = 'VeryLazy',
  config = function ()
    vim.opt.laststatus = 3

    require('feline').setup({
      components = {
        active= {
          {
            wrap_right(components.vi_mode),
            wrap_right(components.git.branch, separators.hard),
            wrap_right(components.cwd),
          }, {
            wrap_right(components.noice.search, separators.hard),
            wrap_right(components.noice.mode, separators.hard),
            wrap_right(components.file.tabs, separators.hard),
            wrap_right(components.file.encoding, separators.hard),
            wrap_right(components.file.format),
          },
        },
      },
      vi_mode_colors = vi_mode_colors,
      force_inactive = {},
    })

    require('feline').winbar.setup({
      components = {
        active = {
          {
            components.buffer.is_active,
            wrap_left(components.file.info),
            wrap_left(components.git.diff_added),
            wrap_left(components.git.diff_changed),
            wrap_left(components.git.diff_removed),
            wrap_left(components.lsp.symbols, separators.arrow),
          }, {
            wrap_right(components.lsp.diagnostics.err),
            wrap_right(components.lsp.diagnostics.warn),
            wrap_right(components.lsp.diagnostics.hint),
            wrap_right(components.lsp.diagnostics.info),
            wrap_right(components.file.position),
            wrap_right(components.file.position_percent),
          }
        },
        inactive = {
          {
            components.buffer.is_inactive,
            wrap_left(components.file.info),
            wrap_left(components.git.diff_added),
            wrap_left(components.git.diff_changed),
            wrap_left(components.git.diff_removed),
          }, {
            wrap_right(components.lsp.diagnostics.err),
            wrap_right(components.lsp.diagnostics.warn),
            wrap_right(components.lsp.diagnostics.hint),
            wrap_right(components.lsp.diagnostics.info),
            wrap_right(components.file.position),
            wrap_right(components.file.position_percent),
          }
        },
      },
      force_inactive = {},
    })

    local augroup = vim.api.nvim_create_augroup('user.plugins.feline', { clear = true })
    vim.api.nvim_create_autocmd('ColorScheme', { group = augroup, callback = function () require('feline').use_theme(get_theme()) end })
    require('feline').use_theme(get_theme())
  end,
}
