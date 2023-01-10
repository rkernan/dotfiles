local hl = require('user.utils.hl')
local feline = require('feline')
local vi_mode = require('feline.providers.vi_mode')
local diagnostic_icons = require('user.lsp.diagnostics').icons

local function get_theme()
  return {
    fg = hl.get_hl('StatusLine').fg,
    bg = hl.get_hl('StatusLine').bg,
    -- terminal colors
    black = hl.get_termhl(0),
    red = hl.get_termhl(1),
    green = hl.get_termhl(2),
    yellow = hl.get_termhl(3),
    blue = hl.get_termhl(4),
    magenta = hl.get_termhl(5),
    cyan = hl.get_termhl(6),
    white = hl.get_termhl(7),
    -- diagnostic colors
    diagnostic_errors = hl.get_hl('DiagnosticSignError').fg,
    diagnostic_warnings = hl.get_hl('DiagnosticSignWarn').fg,
    diagnostic_hints = hl.get_hl('DiagnosticSignHint').fg,
    diagnostic_info = hl.get_hl('DiagnosticSignInfo').fg,
    -- gitsigns colors
    git_diff_added = hl.get_hl('GitSignsAdd').fg,
    git_diff_changed = hl.get_hl('GitSignsChange').fg,
    git_diff_removed = hl.get_hl('GitSignsDelete').fg,
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

local separators = {
  hard = { str = ' | ', hl = { fg = 'black' }},
  soft = { str = ' ' },
}

local function file_encoding()
  if string.lower(vim.bo.fileencoding) ~= 'utf-8' then
    return vim.bo.fileencoding
  end
  return ''
end

local function get_cwd()
  return vim.fn.fnamemodify(vim.fn.getcwd(), ':~')
end

local function file_format()
  if string.lower(vim.bo.fileformat) ~= 'unix' then
    return vim.bo.fileformat
  end
  return ''
end

local function workspace_diagnostics(severity)
  local count = vim.tbl_count(vim.diagnostic.get(nil, severity and { severity = severity }))
  return count ~= 0 and tostring(count) or ''
end

local function workspace_diagnostics_err()
  return workspace_diagnostics(vim.diagnostic.severity.ERROR)
end

local function workspace_diagnostics_warn()
  return workspace_diagnostics(vim.diagnostic.severity.WARN)
end

local function workspace_diagnostics_hint()
  return workspace_diagnostics(vim.diagnostic.severity.HINT)
end

local function workspace_diagnostics_info()
  return workspace_diagnostics(vim.diagnostic.severity.INFO)
end

local components = {
  buffer = {
    is_active = {
      provider = ' ● ',
      hl = { fg = 'green' },
    },
    is_inactive = {
      provider = ' ● ',
      hl = { fg = 'white' },
    },
  },
  cwd = {
    provider = get_cwd,
  },
  git = {
    branch = {
      provider = 'git_branch',
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
      provider = file_encoding,
      hl = { fg = 'red' },
    },
    format = {
      provider = file_format,
      hl = { fg = 'red' },
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
  },
  lsp = {
    clients = {
      provider = function ()
        return require('user.lsp.progress').progress_status() or ''
      end,
      icon = ' ',
    },
    diagnostics = {
      err  = {
        provider = 'diagnostic_errors',
        icon = diagnostic_icons.error,
        hl = { fg = 'diagnostic_errors' },
      },
      warn = {
        provider = 'diagnostic_warnings',
        icon = diagnostic_icons.warn,
        hl = { fg = 'diagnostic_warnings' },
      },
      hint = {
        provider = 'diagnostic_hints',
        icon = diagnostic_icons.hint,
        hl = { fg = 'diagnostic_hints' },
      },
      info = {
        provider = 'diagnostic_info',
        icon = diagnostic_icons.info,
        hl = { fg = 'diagnostic_info' },
      },
    },
    workspace_diagnostics = {
      err  = {
        provider = workspace_diagnostics_err,
        icon = diagnostic_icons.error,
        hl = { fg = 'diagnostic_errors' },
      },
      warn = {
        provider = workspace_diagnostics_warn,
        icon = diagnostic_icons.warn,
        hl = { fg = 'diagnostic_warnings' },
      },
      hint = {
        provider = workspace_diagnostics_hint,
        icon = diagnostic_icons.hint,
        hl = { fg = 'diagnostic_hints' },
      },
      info = {
        provider = workspace_diagnostics_info,
        icon = diagnostic_icons.info,
        hl = { fg = 'diagnostic_info' },
      },
    },
  },
  vi_mode = {
    provider = function ()
      return string.format(' %s ', vi_mode_text[vim.fn.mode()]:sub(1, 1))
    end,
    hl = function ()
      return {
        name = vi_mode.get_mode_highlight_name(),
        fg = 'black',
        bg = vi_mode.get_mode_color(),
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

vim.opt.laststatus = 3

feline.setup({
  components = {
    active= {
      {
        components.vi_mode,
        wrap_left(components.cwd),
        wrap_left(components.git.branch, separators.hard),
        wrap_left(components.file.info, separators.hard),
      }, {
        wrap_right(components.lsp.workspace_diagnostics.err),
        wrap_right(components.lsp.workspace_diagnostics.warn),
        wrap_right(components.lsp.workspace_diagnostics.hint),
        wrap_right(components.lsp.workspace_diagnostics.info),
        wrap_right(components.lsp.clients, separators.hard),
        wrap_right(components.file.format, separators.hard),
        wrap_right(components.file.encoding, separators.hard),
        wrap_right(components.file.position),
        wrap_right(components.file.position_percent),
      }
    },
  },
  vi_mode_colors = vi_mode_colors,
  force_inactive = {},
})

feline.winbar.setup({
  components = {
    active = {
      {
        components.buffer.is_active,
        wrap_left(components.file.info),
        wrap_left(components.git.diff_added),
        wrap_left(components.git.diff_changed),
        wrap_left(components.git.diff_removed),
      }, {
        wrap_right(components.lsp.diagnostics.err),
        wrap_right(components.lsp.diagnostics.warn),
        wrap_right(components.lsp.diagnostics.hint),
        wrap_right(components.lsp.diagnostics.info),
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
      }
    },
  },
  force_inactive = {},
})

local augroup = vim.api.nvim_create_augroup('user.plugins.feline', { clear = true })
vim.api.nvim_create_autocmd('ColorScheme', { group = augroup, callback = function () feline.use_theme(get_theme()) end })
feline.use_theme(get_theme())
