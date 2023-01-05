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
      hl = { fg = 'magenta' },
    },
    diff_added = {
      provider = 'git_diff_added',
      icon = '+',
      left_sep = ' ',
      hl = { fg = 'git_diff_added' },
    },
    diff_changed = {
      provider = 'git_diff_changed',
      icon = '~',
      left_sep = ' ',
      hl = { fg = 'git_diff_changed' },
    },
    diff_removed = {
      provider = 'git_diff_removed',
      icon = '-',
      left_sep = ' ',
      hl = { fg = 'git_diff_removed' },
    },
  },
  lsp = {
    diagnostics = {
      err  = {
        provider = 'diagnostic_errors',
        icon = diagnostic_icons.error,
        left_sep = ' ',
        hl = { fg = 'diagnostic_errors' },
      },
      warn = {
        provider = 'diagnostic_warnings',
        icon = diagnostic_icons.warn,
        left_sep = ' ',
        hl = { fg = 'diagnostic_warnings' },
      },
      hint = {
        provider = 'diagnostic_hints',
        icon = diagnostic_icons.hint,
        left_sep = ' ',
        hl = { fg = 'diagnostic_hints' },
      },
      info = {
        provider = 'diagnostic_info',
        icon = diagnostic_icons.info,
        left_sep = ' ',
        hl = { fg = 'diagnostic_info' },
      },
    },
    clients = {
      privider = 'lsp_client_names',
      icon = ' ',
      left_sep = '  ',
    },
    clients_with_spinner = {
      provider = function ()
        return require('user.lsp.progress').progres_status() or ''
      end,
      icon = ' ',
      left_sep = '  ',
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

vim.opt.laststatus = 3

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
        components.lsp.clients_with_spinner,
        components.lsp.diagnostics.err,
        components.lsp.diagnostics.warn,
        components.lsp.diagnostics.hint,
        components.lsp.diagnostics.info,
      },
    },
  },
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
      },
    },
    inactive = {
      {
        components.file.position_percent,
        components.file.position,
        components.file.info,
      },
    },
  },
  force_inactive = {},
})

local augroup = vim.api.nvim_create_augroup('user.plugins.feline', { clear = true })
vim.api.nvim_create_autocmd('ColorScheme', { group = augroup, callback = function () feline.use_theme(get_theme()) end })
feline.use_theme(get_theme())
