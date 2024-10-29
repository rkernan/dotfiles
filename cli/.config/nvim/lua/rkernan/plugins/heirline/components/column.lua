local M = {}

local ffi = require('ffi')

ffi.cdef([[
  uint64_t display_tick;
  typedef struct {} Error;
  typedef struct {} win_T;
  typedef struct {
    int start;  // line number where deepest fold starts
    int level;  // fold level, when zero other fields are N/A
    int llevel; // lowest level that starts in v:lnum
    int lines;  // number of lines from v:lnum to end of closed fold
  } foldinfo_T;
  foldinfo_T fold_info(win_T* wp, int lnum);
  win_T* find_window_by_handle(int Window, Error* err);
  int compute_foldcolumn(win_T* wp, int col);
]])

local function statuscolumn_click_args(minwid, clicks, button, mods)
  return {
    minwid = minwid,
    clicks = clicks,
    button = button,
    mods = mods,
    bufnr = vim.api.nvim_win_get_buf(minwid),
    mousepos = vim.fn.getmousepos(),
  }
end

M.line_number = {
  fallthrough = false,
  on_click = {
    callback = function (_, ...)
      local args = statuscolumn_click_args(...)
      local curpos = vim.fn.getcurpos()
      vim.api.nvim_set_current_win(args.mousepos.winid)
      if args.mousepos.line ~= curpos[2] then
        vim.api.nvim_win_set_cursor(args.mousepos.winid, { args.mousepos.line, math.min(curpos[3], vim.fn.col('$')) })
      else
        local available, dap = pcall(require, 'dap')
        if available then
          dap.toggle_breakpoint()
        end
      end
    end,
    name = 'heirline_statuscolumn_lnum',
  }, {
    -- FIXME future remove %r and handle this for us
    -- https://github.com/neovim/neovim/commit/ad70c9892d5b5ebcc106742386c99524f074bcea/
    condition = function ()
      return vim.wo.relativenumber and vim.v.lnum ~= vim.fn.getcurpos()[2]
    end,
    provider = '%r ',
  }, {
    provider = '%l ',
  }
}

M.folds = {
  fallthrough = false,
  init = function (self)
    local wp = ffi.C.find_window_by_handle(0, ffi.new('Error'))
    self.width = ffi.C.compute_foldcolumn(wp, 0)
    if self.width > 0 then
      self.foldinfo = ffi.C.fold_info(wp, vim.v.lnum) or { start = 0, level = 0, llevel = 0, lines = 0 }
      self.icons = {
        foldclose = vim.opt_local.fillchars:get().foldclose,
        foldopen = vim.opt_local.fillchars:get().foldopen,
        foldsep = vim.opt_local.fillchars:get().foldsep,
      }
    end
  end,
  on_click = {
    callback = function (_, ...)
      local args = statuscolumn_click_args(...)
      local char = vim.fn.screenstring(args.mousepos.screenrow, args.mousepos.screencol)
      local fillchars = vim.opt_local.fillchars:get()

      -- save position
      local saved_pos = vim.api.nvim_win_get_cursor(args.minwid)
      vim.api.nvim_set_current_win(args.mousepos.winid)
      vim.api.nvim_win_set_cursor(args.mousepos.winid, { args.mousepos.line, 0 })

      if char == fillchars.foldopen then
        vim.cmd([[norm! zc]])
      elseif char == fillchars.foldclose then
        vim.cmd([[norm! zo]])
      end

      -- restore position
      vim.api.nvim_set_current_win(args.minwid)
      vim.api.nvim_win_set_cursor(args.minwid, saved_pos)
    end,
    name = 'heirline_statuscolumn_folds',
  }, {
    -- folds are disabled
    condition = function (self)
      return self.width == 0
    end,
    provider = ''
  }, {
    -- line does not have any folds
    condition = function (self)
      return self.foldinfo.level == 0
    end,
    provider = '  ',
  }, {
    -- line is first line in a closed fold
    condition = function (self)
      return self.foldinfo.lines > 0
    end,
    provider = function (self)
      return self.icons.foldclose .. ' '
    end,
  }, {
    -- line is the first line in an open fold
    condition = function (self)
      return self.foldinfo.start == vim.v.lnum
    end,
    provider = function (self)
      return self.icons.foldopen .. ' '
    end,
  }, {
    provider = function (self)
      return self.icons.foldsep .. ' '
    end,
  },
  hl = 'FoldColumn',
}

M.signs = {
  provider = '%s',
}

local SignsCache = {
}

function SignsCache:new()
  local o = {
    signs = {},
    last_display_tick = {},
  }
  setmetatable(o, self)
  self.__index = self
  return o
end

function SignsCache:setup()
  -- augroup = vim.api.nvim_create_augroup('SignsCache', { clear = true })
  vim.api.nvim_create_autocmd('BufDelete', {
    -- group = augroup,
    callback = function (args)
      self:reset(args.buf)
      table.remove(self.last_display_tick, args.buf)
    end,
  })
end

function SignsCache:insert(bufnr, row, sign)
  -- initialize rows
  self.signs[bufnr] = self.signs[bufnr] or {}
  self.signs[bufnr][sign.ns_id] = self.signs[bufnr][sign.ns_id] or {}
  self.signs[bufnr][sign.ns_id][row] = self.signs[bufnr][sign.ns_id][row] or {}
  -- trim whitespace
  sign.sign_text = sign.sign_text:gsub('%s+', '')
  -- insert
  table.insert(self.signs[bufnr][sign.ns_id][row], sign)
  -- sort by priority
  table.sort(self.signs[bufnr][sign.ns_id][row], function (a, b) return a.priority > b.priority end)
end

function SignsCache:reset(bufnr)
  table.remove(self.signs, bufnr)
end

function SignsCache:update(bufnr)
  -- only update once per display tick
  self.last_display_tick[bufnr] = self.last_display_tick[bufnr] or 0
  if self.last_display_tick[bufnr] > ffi.C.display_tick then
    return false
  elseif self.last_display_tick[bufnr] == ffi.C.display_tick then
    return true
  end
  self.last_display_tick[bufnr] = ffi.C.display_tick
  -- reset buffer signs
  self:reset(bufnr)
  -- gather all signs
  local extmarks = vim.api.nvim_buf_get_extmarks(bufnr, -1, 0, -1, { type = 'sign', details = true })
  for _, extmark in ipairs(extmarks) do
    self:insert(bufnr, extmark[2], extmark[4])
  end
  return true
end

function SignsCache:get(bufnr, ns_id, row)
  if self.signs[bufnr] and self.signs[bufnr][ns_id] and self.signs[bufnr][ns_id][row] then
    return self.signs[bufnr][ns_id][row]
  end
  return {}
end

function SignsCache:pop(bufnr, ns_id, row)
  local res = {}
  if self.signs[bufnr] and self.signs[bufnr][ns_id] and self.signs[bufnr][ns_id][row] then
    res = self.signs[bufnr][ns_id][row]
    table.remove(self.signs[bufnr][ns_id], row)
  end
  return res
end

function SignsCache:has_buf_signs(bufnr, ns_id)
  if self.signs[bufnr] and self.signs[bufnr][ns_id] then
    return #self.signs[bufnr][ns_id]
  end
  return false
end

local signs_cache = SignsCache:new()
signs_cache:setup()

local gitsigns_display_cache = nil
M.gitsigns = {
  fallthrough = false,
  init = function (self)
    -- setup cache if it doesn't exist
    if not gitsigns_display_cache then
      gitsigns_display_cache = SignsCache:new()
      gitsigns_display_cache:setup()
    end

    self.bufnr = vim.fn.bufnr()
    -- gather namespaces
    self.ns_ids = {}
    self.ns_ids.staged = vim.api.nvim_get_namespaces()['gitsigns_signs_staged']
    self.ns_ids.unstaged = vim.api.nvim_get_namespaces()['gitsigns_signs_']
    -- update signs cache
    if signs_cache:update(self.bufnr) then
      -- gather signs from rolling cache
      gitsigns_display_cache:reset(self.bufnr)
      for _, sign in ipairs(signs_cache:pop(self.bufnr, self.ns_ids.staged, vim.v.lnum - 1)) do
        gitsigns_display_cache:insert(self.bufnr, vim.v.lnum - 1, sign)
      end
      for _, sign in ipairs(signs_cache:pop(self.bufnr, self.ns_ids.unstaged, vim.v.lnum - 1)) do
        gitsigns_display_cache:insert(self.bufnr, vim.v.lnum - 1, sign)
      end
    end
    -- gather signs from display cache
    self.signs = {}
    self.signs.staged = gitsigns_display_cache:get(self.bufnr, self.ns_ids.staged, vim.v.lnum - 1)
    self.signs.unstaged = gitsigns_display_cache:get(self.bufnr, self.ns_ids.unstaged, vim.v.lnum - 1)
  end,
  {
    condition = function (self)
      return not signs_cache:has_buf_signs(self.bufnr, self.ns_ids.staged) and not signs_cache:has_buf_signs(self.bufnr, self.ns_ids.unstaged)
    end,
    provider = ''
  }, {
    condition = function (self)
      return #self.signs.staged > 0
    end,
    provider = function (self)
      return self.signs.staged[1].sign_text
    end,
    hl = function (self)
      return self.signs.staged[1].sign_hl_group
    end,
  }, {
    condition = function (self)
      return #self.signs.unstaged > 0
    end,
    provider = function (self)
      return self.signs.unstaged[1].sign_text
    end,
    hl = function (self)
      return self.signs.unstaged[1].sign_hl_group
    end,
  }, {
    provider = ' ',
  }
}

local diagnostics_display_cache = nil
M.diagnostics = {
  -- FIXME only update on DiagnosticChanged
  fallthrough = false,
  init = function (self)
    -- setup cache if it doesn't exist
    if not diagnostics_display_cache then
      diagnostics_display_cache = SignsCache:new()
      diagnostics_display_cache:setup()
    end

    self.bufnr = vim.fn.bufnr()
    -- gather namespaces
    self.ns_ids = {}
    self.has_buf_signs = false
    for namespace, ns_id in pairs(vim.api.nvim_get_namespaces()) do
      if string.match(namespace, 'diagnostic/signs') then
        table.insert(self.ns_ids, ns_id)
        -- check if we have any buffer signs
        self.has_buf_signs = self.has_buf_signs or signs_cache:has_buf_signs(self.bufnr, ns_id)
      end
    end
    -- update signs cache
    if signs_cache:update(self.bufnr) then
      -- gather from rolling cache
      diagnostics_display_cache:reset(self.bufnr)
      for _, ns_id in ipairs(self.ns_ids) do
        for _, sign in ipairs(signs_cache:pop(self.bufnr, ns_id, vim.v.lnum - 1)) do
          diagnostics_display_cache:insert(self.bufnr, vim.v.lnum - 1, sign)
        end
      end
    end
    -- gather signs from display cache
    self.signs = {}
    for _, ns_id in ipairs(self.ns_ids) do
      for _, sign in ipairs(diagnostics_display_cache:get(self.bufnr, ns_id, vim.v.lnum - 1)) do
        table.insert(self.signs, sign)
      end
    end
    -- sort by priority
    table.sort(self.signs, function (a, b) return a.priority > b.priority end)
  end,
  {
    condition = function (self)
      return not self.has_buf_signs
    end,
    provider = '',
  }, {
    condition = function (self)
      return #self.signs > 0
    end,
    provider = function (self)
      return self.signs[1].sign_text
    end,
    hl = function (self)
      return self.signs[1].sign_hl_group
    end,
  }, {
    provider = ' '
  }
}

return M
