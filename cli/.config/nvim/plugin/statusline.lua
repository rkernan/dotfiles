local diagnostics_icons = require('rkernan.diagnostics').signs

local Part = {}

function Part:new(value)
  local opts = {
    value = value,
  }
  setmetatable(opts, self)
  self.__index = self
  return opts
end

function Part:apply(cb)
  if self.value == '' or self.value == nil then
    return self
  end
  return Part:new(cb(self.value))
end

function Part:hl(color)
  return self:apply(function (v) return string.format('%%#%s#%s%%*', color, v) end)
end

function Part:format(format)
  return self:apply(function (v) return string.format(format, v) end)
end

local modes = {
  ['n']     = { name = 'NORMAL',    shortname = 'N',   hl = 'StatusLineModeNormal'   },
  ['no']    = { name = 'O-PENDING', shortname = 'N',   hl = 'StatusLineModeNormal'   },
  ['nov']   = { name = 'O-PENDING', shortname = 'N',   hl = 'StatusLineModeNormal'   },
  ['noV']   = { name = 'O-PENDING', shortname = 'N',   hl = 'StatusLineModeNormal'   },
  ['no\22'] = { name = 'O-PENDING', shortname = 'N',   hl = 'StatusLineModeNormal'   },
  ['niI']   = { name = 'NORMAL',    shortname = 'N',   hl = 'StatusLineModeNormal'   },
  ['niR']   = { name = 'NORMAL',    shortname = 'N',   hl = 'StatusLineModeNormal'   },
  ['niV']   = { name = 'NORMAL',    shortname = 'N',   hl = 'StatusLineModeNormal'   },
  ['nt']    = { name = 'NORMAL',    shortname = 'N',   hl = 'StatusLineModeNormal'   },
  ['ntT']   = { name = 'NORMAL',    shortname = 'N',   hl = 'StatusLineModeNormal'   },
  ['v']     = { name = 'VISUAL',    shortname = 'V',   hl = 'StatusLineModeVisual'   },
  ['vs']    = { name = 'VISUAL',    shortname = 'V',   hl = 'StatusLineModeVisual'   },
  ['V']     = { name = 'V-LINE',    shortname = 'V-L', hl = 'StatusLineModeVisual'   },
  ['Vs']    = { name = 'V-LINE',    shortname = 'V-L', hl = 'StatusLineModeVisual'   },
  ['\22']   = { name = 'V-BLOCK',   shortname = 'V-B', hl = 'StatusLineModeVisual'   },
  ['\22s']  = { name = 'V-BLOCK',   shortname = 'V-B', hl = 'StatusLineModeVisual'   },
  ['s']     = { name = 'SELECT',    shortname = 'S',   hl = 'StatusLineModeReplace'  },
  ['S']     = { name = 'S-LINE',    shortname = 'S-L', hl = 'StatusLineModeReplace'  },
  ['\19']   = { name = 'S-BLOCK',   shortname = 'S-B', hl = 'StatusLineModeReplace'  },
  ['i']     = { name = 'INSERT',    shortname = 'I',   hl = 'StatusLineModeInsert'   },
  ['ic']    = { name = 'INSERT',    shortname = 'I',   hl = 'StatusLineModeInsert'   },
  ['ix']    = { name = 'INSERT',    shortname = 'I',   hl = 'StatusLineModeInsert'   },
  ['R']     = { name = 'REPLACE',   shortname = 'R',   hl = 'StatusLineModeReplace'  },
  ['Rc']    = { name = 'REPLACE',   shortname = 'R',   hl = 'StatusLineModeReplace'  },
  ['Rx']    = { name = 'REPLACE',   shortname = 'R',   hl = 'StatusLineModeReplace'  },
  ['Rv']    = { name = 'V-REPLACE', shortname = 'R-V', hl = 'StatusLineModeReplace'  },
  ['Rvc']   = { name = 'V-REPLACE', shortname = 'R-V', hl = 'StatusLineModeReplace'  },
  ['Rvx']   = { name = 'V-REPLACE', shortname = 'R-V', hl = 'StatusLineModeReplace'  },
  ['c']     = { name = 'COMMAND',   shortname = 'C',   hl = 'StatusLineModeCommand'  },
  ['cv']    = { name = 'EX',        shortname = 'C',   hl = 'StatusLineModeCommand'  },
  ['ce']    = { name = 'EX',        shortname = 'C',   hl = 'StatusLineModeCommand'  },
  ['r']     = { name = 'REPLACE',   shortname = 'R',   hl = 'StatusLineModeReplace'  },
  ['rm']    = { name = 'MORE',      shortname = 'R',   hl = 'StatusLineModeReplace', },
  ['r?']    = { name = 'CONFIRM',   shortname = 'R',   hl = 'StatusLineModeReplace', },
  ['!']     = { name = 'SHELL',     shortname = 'S',   hl = 'StatusLineModeTerminal' },
  ['t']     = { name = 'TERMINAL',  shortname = 'T',   hl = 'StatusLineModeTerminal' },
}

local function mode()
  local current_mode = modes[vim.fn.mode(1)]
  return Part:new(string.format(' %s ', current_mode.shortname)):hl(current_mode.hl)
end

local function environment(variable)
  return Part:new(vim.fn.environ()[variable] or '')
end

local function git_head()
  return Part:new(vim.g.git_head or '')
end

local function get_current_bufnr()
  return vim.api.nvim_win_get_buf(vim.g.statusline_winid)
end

local function cwd()
  local part = Part:new(vim.fn.fnamemodify(vim.fn.getcwd(), ':~'))
  if part.value:sub(-1) == '/' then
    return part
  end
  return part:format('%s/')
end

local function file_icon()
  local ok, mini_icons = pcall(require, 'mini.icons')
  if ok then
    local icon, hl, _ = mini_icons.get('file', vim.api.nvim_buf_get_name(get_current_bufnr()))
    return Part:new(icon):hl(hl)
  else
    return Part:new('󰈔')
  end
end

local function modified()
  if vim.bo[get_current_bufnr()].modified then
    return Part:new('+')
  end
  return Part:new('')
end

local function readonly()
  local bufnr = get_current_bufnr()
  if not vim.bo[bufnr].modifiable or vim.bo[bufnr].readonly then
    return Part:new('')
  end
  return Part:new('')
end

local function tabsummary()
  local bufnr = get_current_bufnr()
  if vim.bo[bufnr].expandtab then
    return Part:new(string.format('tab:%d,et', vim.bo[bufnr].shiftwidth))
  else
    return Part:new(string.format('tab:%d', vim.bo[bufnr].tabstop))
  end
end

local function fileformat()
  return Part:new(vim.bo[get_current_bufnr()].fileformat)
end

local function fileencoding()
  return Part:new(vim.bo[get_current_bufnr()].fileencoding)
end

local diff = {}

local function _diff(v)
  local count = 0
  local bufnr = get_current_bufnr()
  if vim.b[bufnr].minidiff_summary then
    count = vim.b[bufnr].minidiff_summary[v] or 0
  end

  if count > 0 then
    return Part:new(tostring(count))
  end
  return Part:new('')
end

function diff.add()
  return _diff('add')
end

function diff.change()
  return _diff('change')
end

function diff.delete()
  return _diff('delete')
end

local diagnostics = {}

local function _diagnostics(severity)
  local count = #vim.diagnostic.get(get_current_bufnr(), { severity = severity })
  if count > 0 then
    return Part:new(tostring(count))
  end
    return Part:new('')
end

function diagnostics.error()
  return _diagnostics(vim.diagnostic.severity.ERROR)
end

function diagnostics.warn()
  return _diagnostics(vim.diagnostic.severity.WARN)
end

function diagnostics.info()
  return _diagnostics(vim.diagnostic.severity.INFO)
end

function diagnostics.hint()
  return _diagnostics(vim.diagnostic.severity.HINT)
end

function Statusline()
  return table.concat({
    mode().value,
    git_head():format('  %s'):hl('StatusLineGitHead').value,
    environment('VIRTUAL_ENV'):apply(function (v) return vim.fn.fnamemodify(v, ':t') end):format('  %s'):hl('StatusLineVirtualEnv').value,
    cwd():format('  %s').value,
    "%=",
    tabsummary().value,
    fileformat():format(' %s').value,
    fileencoding():format(' %s').value,
  })
end

function WinBarActive()
  return table.concat({
    file_icon():format('%s ').value,
    '%f',
    modified():format(' %s'):hl('WinBarModified').value,
    readonly():format(' %s'):hl('WinBarReadonly').value,
    diff.add():format(' +%s'):hl('WinBarDiffAdd').value,
    diff.change():format(' ~%s'):hl('WinBarDiffChange').value,
    diff.delete():format(' -%s'):hl('WinBarDiffDelete').value,
    "%=",
    diagnostics.error():format(string.format('%s %%s ', diagnostics_icons[vim.diagnostic.severity.ERROR])):hl('WinBarDiagnosticError').value,
    diagnostics.warn():format(string.format('%s %%s ', diagnostics_icons[vim.diagnostic.severity.WARN])):hl('WinBarDiagnosticWarn').value,
    diagnostics.info():format(string.format('%s %%s ', diagnostics_icons[vim.diagnostic.severity.INFO])):hl('WinBarDiagnosticInfo').value,
    diagnostics.hint():format(string.format('%s %%s ', diagnostics_icons[vim.diagnostic.severity.HINT])):hl('WinBarDiagnosticHint').value,
    ' %l:%L %P',
  })
end

function WinBarInactive()
  return table.concat({
    file_icon():format('%s ').value,
    '%f%m%r',
    modified():format(' %s'):hl('WinBarModified').value,
    readonly():format(' %s'):hl('WinBarReadonly').value,
    diff.add():format(' +%s'):hl('WinBarDiffAdd').value,
    diff.change():format(' ~%s'):hl('WinBarDiffChange').value,
    diff.delete():format(' -%s'):hl('WinBarDiffDelete').value,
    "%=",
    diagnostics.error():format(string.format('%s %%s ', diagnostics_icons[vim.diagnostic.severity.ERROR])):hl('WinBarDiagnosticError').value,
    diagnostics.warn():format(string.format('%s %%s ', diagnostics_icons[vim.diagnostic.severity.WARN])):hl('WinBarDiagnosticWarn').value,
    diagnostics.info():format(string.format('%s %%s ', diagnostics_icons[vim.diagnostic.severity.INFO])):hl('WinBarDiagnosticInfo').value,
    diagnostics.hint():format(string.format('%s %%s ', diagnostics_icons[vim.diagnostic.severity.HINT])):hl('WinBarDiagnosticHint').value,
    ' %l:%L %P',
  })
end

function StatusColumn()
  return '%C%=%l %s'
end

local function setup_colors()
  local statusline        = vim.api.nvim_get_hl(0, { name = 'StatusLine',          link = false })
  local minidiff_add      = vim.api.nvim_get_hl(0, { name = 'MiniDiffSignAdd',     link = false })
  local minidiff_change   = vim.api.nvim_get_hl(0, { name = 'MiniDiffSignChange',  link = false })
  local minidiff_delete   = vim.api.nvim_get_hl(0, { name = 'MiniDiffSignDelete',  link = false })
  local diagnostics_error = vim.api.nvim_get_hl(0, { name = 'DiagnosticSignError', link = false })
  local diagnostics_warn  = vim.api.nvim_get_hl(0, { name = 'DiagnosticSignWarn',  link = false })
  local diagnostics_info  = vim.api.nvim_get_hl(0, { name = 'DiagnosticSignInfo',  link = false })
  local diagnostics_hint  = vim.api.nvim_get_hl(0, { name = 'DiagnosticSignHint',  link = false })
  vim.api.nvim_set_hl(0, 'StatusLineModeNormal',    { fg = statusline.bg,          bg = vim.g.terminal_color_7 })
  vim.api.nvim_set_hl(0, 'StatusLineModeVisual',    { fg = statusline.bg,          bg = vim.g.terminal_color_1 })
  vim.api.nvim_set_hl(0, 'StatusLineModeReplace',   { fg = statusline.bg,          bg = vim.g.terminal_color_1 })
  vim.api.nvim_set_hl(0, 'StatusLineModeInsert',    { fg = statusline.bg,          bg = vim.g.terminal_color_4 })
  vim.api.nvim_set_hl(0, 'StatusLineModeCommand',   { fg = statusline.bg,          bg = vim.g.terminal_color_2 })
  vim.api.nvim_set_hl(0, 'StatusLineModeTerminal',  { fg = statusline.bg,          bg = vim.g.terminal_color_3 })
  vim.api.nvim_set_hl(0, 'StatusLineGitHead',     { fg = vim.g.terminal_color_5 })
  vim.api.nvim_set_hl(0, 'StatusLineVirtualEnv',  { fg = vim.g.terminal_color_6 })
  vim.api.nvim_set_hl(0, 'WinBarModified',        { fg = vim.g.terminal_color_2 })
  vim.api.nvim_set_hl(0, 'WinBarReadonly',        { fg = vim.g.terminal_color_1 })
  vim.api.nvim_set_hl(0, 'WinBarDiffAdd',         { fg = minidiff_add.fg        })
  vim.api.nvim_set_hl(0, 'WinBarDiffChange',      { fg = minidiff_change.fg     })
  vim.api.nvim_set_hl(0, 'WinBarDiffDelete',      { fg = minidiff_delete.fg     })
  vim.api.nvim_set_hl(0, 'WinBarDiagnosticError', { fg = diagnostics_error.fg   })
  vim.api.nvim_set_hl(0, 'WinBarDiagnosticWarn',  { fg = diagnostics_warn.fg    })
  vim.api.nvim_set_hl(0, 'WinBarDiagnosticInfo',  { fg = diagnostics_info.fg    })
  vim.api.nvim_set_hl(0, 'WinBarDiagnosticHint',  { fg = diagnostics_hint.fg    })
end

local augroup = vim.api.nvim_create_augroup('rkernan.statusline', { clear = true })
vim.api.nvim_create_autocmd({'VimEnter', 'ColorScheme'}, { callback = setup_colors, group = augroup })

vim.opt.laststatus = 3
vim.opt.statusline = '%!v:lua.Statusline()'

vim.opt.signcolumn = 'yes'
vim.opt.statuscolumn = '%!v:lua.StatusColumn()'

local function should_skip(bufnr)
  for _, pattern in ipairs({ 'nofile', 'help', 'prompt', 'quickfix', 'terminal' }) do
    if vim.bo[bufnr].buftype:find(pattern) then
      return true
    end
  end
  return false
end

vim.api.nvim_create_autocmd({ 'WinEnter', 'BufEnter' }, {
  group = augroup,
  callback = function (args)
    if should_skip(args.buf) then
      return
    end
    vim.opt_local.winbar = '%!v:lua.WinBarActive()'
  end
})

vim.api.nvim_create_autocmd({ 'WinLeave', 'BufLeave' }, {
  group = augroup,
  callback = function (args)
    if should_skip(args.buf) then
      return
    end
    vim.opt_local.winbar = '%!v:lua.WinBarInactive()'
  end
})

local function redraw_status()
  vim.schedule(function () vim.cmd.redrawstatus() end)
end

vim.api.nvim_create_autocmd('DiagnosticChanged', { group = augroup, callback = redraw_status })
vim.api.nvim_create_autocmd({ 'User' }, { pattern = { 'GitHeadUpdate', 'MiniDiffUpdated' }, group = augroup, callback = redraw_status })
