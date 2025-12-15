local M = {}

---@class Part
---@field value string
local Part = {}

function Part:new(value)
  local opts = {
    value = value,
  }
  setmetatable(opts, self)
  self.__index = self
  return opts
end

---Apply callback to the part
---@param cb fun(cb: string): string
---@return Part
function Part:apply(cb)
  if self.value == '' or self.value == nil then
    return self
  end
  return Part:new(cb(self.value))
end

---Highlight the part if non-empty
---@param color string Hightlight group
---@return Part
function Part:hl(color)
  return self:apply(function (v) return string.format('%%#%s#%s%%*', color, v) end)
end

---Format the part
---@param format string Format string
---@return Part
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

---Get current mode part with highlight
---@return  Part
local function mode()
  local current_mode = modes[vim.fn.mode(1)]
  return Part:new(string.format(' %s ', current_mode.shortname)):hl(current_mode.hl)
end

---Get environment part
---@return Part
local function environment(variable)
  return Part:new(vim.fn.environ()[variable] or '')
end

---Get current working directory part
---@return Part
local function cwd()
  local part = Part:new(vim.fn.fnamemodify(vim.fn.getcwd(), ':~'))
  if part.value:sub(-1) == '/' then
    return part
  end
  return part:format('%s/')
end

---Get file icon part (from mini.icons)
---@return Part
local function file_icon(bufnr)
  bufnr = bufnr or 0

  local ok, mini_icons = pcall(require, 'mini.icons')
  if not ok then
    return Part:new('󰈔')
  end

  if vim.bo[bufnr].buftype == 'terminal' then
    return Part:new('')
  end

  local name = vim.api.nvim_buf_get_name(bufnr)
  local icon, _, _ = mini_icons.get('file', name)
  return Part:new(icon)
end

---Get modified flag part
---@return Part
local function modified(bufnr)
  bufnr = bufnr or 0
  if vim.bo[bufnr].modified then
    return Part:new('+')
  end
  return Part:new('')
end

---Get readonly flag part
---@return Part
local function readonly(bufnr)
  bufnr = bufnr or 0
  if not vim.bo[bufnr].modifiable or vim.bo[bufnr].readonly then
    return Part:new('')
  end
  return Part:new('')
end

---Get tab summary part
---@return Part
local function tabsummary(bufnr)
  bufnr = bufnr or 0
  if vim.bo[bufnr].expandtab then
    return Part:new(string.format('tab:%d,et', vim.bo[bufnr].shiftwidth))
  else
    return Part:new(string.format('tab:%d', vim.bo[bufnr].tabstop))
  end
end

---Get file format part
---@return Part
local function fileformat(bufnr)
  bufnr = bufnr or 0
  return Part:new(vim.bo[bufnr].fileformat)
end

local function fileencoding(bufnr)
  bufnr = bufnr or 0
  return Part:new(vim.bo[bufnr].fileencoding)
end

local diff = {}

---@alias DiffField 'add'|'change'|'delete'

---Helper to get given diff status from mini.diff
---@param bufnr? integer Buffer or current buffer
---@param field DiffField Diff type to get
---@return Part
local function _diff(bufnr, field)
  bufnr = bufnr or 0
  local count = 0
  if vim.b[bufnr].minidiff_summary then
    count = vim.b[bufnr].minidiff_summary[field] or 0
  end

  if count > 0 then
    return Part:new(tostring(count))
  end
  return Part:new('')
end

---Get diff add from mini.diff
---@param bufnr? integer Buffer or current buffer
---@return Part
function diff.add(bufnr)
  return _diff(bufnr, 'add')
end

---Get diff change from mini.diff
---@param bufnr? integer Buffer or current buffer
---@return Part
function diff.change(bufnr)
  return _diff(bufnr, 'change')
end

---Get diff delete from mini.diff
---@param bufnr? integer Buffer or current buffer
---@return Part
function diff.delete(bufnr)
  return _diff(bufnr, 'delete')
end

local diagnostics = {}

---Helper to get given diagnostics count
---@param bufnr? integer Buffer or current buffer
---@param severity vim.diagnostic.Severity Diagnostic severity to get
---@return Part
local function _diagnostics(bufnr, severity)
  bufnr = bufnr or 0
  local count = #vim.diagnostic.get(bufnr, { severity = severity })
  if count > 0 then
    local signs = require('rkernan.diagnostic').signs
    return Part:new(tostring(count)):format(('%s %%s'):format(signs[severity]))
  end
    return Part:new('')
end

---Get error diagnostic count part
---@param bufnr? integer Buffer or current buffer
---@return Part
function diagnostics.error(bufnr)
  return _diagnostics(bufnr, vim.diagnostic.severity.ERROR)
end

---Get warning diagnotic count part
---@param bufnr? integer Buffer or current buffer
---@return Part
function diagnostics.warn(bufnr)
  return _diagnostics(bufnr, vim.diagnostic.severity.WARN)
end

---Get info diagnotic count part
---@param bufnr? integer Buffer or current buffer
---@return Part
function diagnostics.info(bufnr)
  return _diagnostics(bufnr, vim.diagnostic.severity.INFO)
end

---Get hint diagnotic count part
---@param bufnr? integer Buffer or current buffer
---@return Part
function diagnostics.hint(bufnr)
  return _diagnostics(bufnr, vim.diagnostic.severity.HINT)
end

---Generate global statusline
---@return string
function MyStatusline()
  return table.concat({
    mode().value,
    Part:new(vim.g.git_head or ''):format('  %s' ):hl('StatusLineGitHead').value,
    environment('VIRTUAL_ENV_PROMPT'):apply(vim.fs.basename):format('  %s'):hl('StatusLineVirtualEnv').value,
    cwd():format(' %s').value,
    '%=',
    tabsummary():hl('StatusLineDim').value,
    fileformat():format(' %s'):hl('StatusLineDim').value,
    fileencoding():format(' %s'):hl('StatusLineDim').value,
  })
end

---Generate the active winbar
---@return string
function MyWinBarActive()
  local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
  return table.concat({
    file_icon(bufnr):format('%s ').value,
    '%f',
    modified(bufnr):format(' %s'):hl('WinBarModified').value,
    readonly(bufnr):format(' %s'):hl('WinBarReadonly').value,
    diff.add(bufnr):format(' +%s'):hl('WinBarDiffAdd').value,
    diff.change(bufnr):format(' ~%s'):hl('WinBarDiffChange').value,
    diff.delete(bufnr):format(' -%s'):hl('WinBarDiffDelete').value,
    "%=",
    diagnostics.error(bufnr):format('%s '):hl('WinBarDiagnosticError').value,
    diagnostics.warn(bufnr):format('%s '):hl('WinBarDiagnosticWarn').value,
    diagnostics.info(bufnr):format('%s '):hl('WinBarDiagnosticInfo').value,
    diagnostics.hint(bufnr):format('%s '):hl('WinBarDiagnosticHint').value,
    ' %l:%L %P',
  })
end

---Generate the inactive winbar
---@return string
function MyWinBarInactive()
  local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
  return table.concat({
    file_icon(bufnr):format('%s ').value,
    '%f%m%r',
    modified(bufnr):format(' %s'):hl('WinBarModified').value,
    readonly(bufnr):format(' %s'):hl('WinBarReadonly').value,
    diff.add(bufnr):format(' +%s'):hl('WinBarDiffAdd').value,
    diff.change(bufnr):format(' ~%s'):hl('WinBarDiffChange').value,
    diff.delete(bufnr):format(' -%s'):hl('WinBarDiffDelete').value,
    "%=",
    diagnostics.error(bufnr):format('%s '):hl('WinBarDiagnosticError').value,
    diagnostics.warn(bufnr):format('%s '):hl('WinBarDiagnosticWarn').value,
    diagnostics.info(bufnr):format('%s '):hl('WinBarDiagnosticInfo').value,
    diagnostics.hint(bufnr):format('%s '):hl('WinBarDiagnosticHint').value,
    ' %l:%L %P',
  })
end

---Generate the status column
---@return string
function MyStatusColumn()
  return table.concat({
    vim.wo[vim.g.statusline_winid].foldenable and '%C ' or '',
    '%=%l ',
    '%s'
  })
end

---Get tab title string
---@param bufnr? integer Buffer or current buffer
---@return string
local function tab_entry_title(bufnr)
  bufnr = bufnr or 0
  local name = vim.api.nvim_buf_get_name(bufnr)
  local buftype = vim.bo[bufnr].buftype

  if buftype == 'terminal' then
    local _, match = string.match(name, "term:(.*):(.*)")
    if match == vim.env.SHELL then
      return vim.fs.basename(match)
    end
    return match
  elseif name == '' then
    return '[No Name]'
  else
    return vim.fn.pathshorten(vim.fn.fnamemodify(name, ':p:~:t'))
  end
end

---Get tab entry part
---@param index integer Tab index
---@return Part
local function tabline_entry(index)
  local bufnr = vim.fn.tabpagebuflist(index)[vim.fn.tabpagewinnr(index)]
  local entry = table.concat({
    string.format('%%%dT', index),
    ' ',
    Part:new(tostring(index)):format('%s ').value,
    file_icon(bufnr):format('%s ').value,
    tab_entry_title(bufnr),
    ' ',
    '%T'
  })
  if vim.fn.tabpagenr() == index then
    return Part:new(entry):hl('TabLineSel').value
  end
  return Part:new(entry):hl('TabLine').value
end

---Generate tab line
---@return string
function MyTabLine()
  local line = ''
  for i = 1, vim.fn.tabpagenr('$') do
    line = line .. tabline_entry(i)
  end
  line = line .. '%#TabLineFill#%='
  return line
end

---Set up auto-command to create statusline colors on ColorScheme
function M.setup_colors()
  local augroup = vim.api.nvim_create_augroup('rkernan.statusline.colors', { clear = true })
  vim.api.nvim_create_autocmd({'VimEnter', 'ColorScheme'}, {
    group = augroup,
    callback = function ()
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
    end,
  })
end

---Set up auto-command to redraw the statusline when necessary
function M.setup_redraw()
  local function redraw_status()
    vim.schedule(function () vim.cmd.redrawstatus() end)
  end

  local augroup = vim.api.nvim_create_augroup('rkernan.statusline.redraw', { clear = true })
  vim.api.nvim_create_autocmd('DiagnosticChanged', { group = augroup, callback = redraw_status })
  vim.api.nvim_create_autocmd({ 'User' }, { pattern = { 'GitHeadUpdate', 'MiniDiffUpdated' }, group = augroup, callback = redraw_status })
end

---Set up auto-command to set active/inactive winbar
function M.setup_winbar()
  local function should_skip(bufnr)
    bufnr = bufnr or 0
    if vim.bo[bufnr].buftype == '' and vim.bo[bufnr].filetype == '' then
      return true
    end

    for _, pattern in ipairs({ 'nofile', 'help', 'prompt', 'quickfix', 'terminal' }) do
      if vim.bo[bufnr].buftype:find(pattern) then
        return true
      end
    end
    return false
  end

  local augroup = vim.api.nvim_create_augroup('rkernan.statusline.winbar', { clear = true })
  vim.api.nvim_create_autocmd({ 'FileType', 'WinEnter' }, {
    group = augroup,
    callback = function (args)
      if should_skip(args.buf) then
        return
      end
      vim.opt_local.winbar = '%!v:lua.MyWinBarActive()'
    end
  })
  vim.api.nvim_create_autocmd('WinLeave', {
    group = augroup,
    callback = function (args)
      if should_skip(args.buf) then
        return
      end
      vim.opt_local.winbar = '%!v:lua.MyWinBarInactive()'
    end
  })
end

return M
