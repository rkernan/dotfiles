local M = {}

local ffi = require('ffi')

ffi.cdef([[
  typedef struct {} Error;
  typedef struct {} win_T;
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
      self.foldclosed = vim.fn.foldclosed(vim.v.lnum)
      self.foldlevel = vim.fn.foldlevel(vim.v.lnum)
      self.foldlevel_before = vim.fn.foldlevel((vim.v.lnum > 1) and (vim.v.lnum - 1) or 1)
      local maxline = vim.fn.line('$')
      self.foldlevel_after = vim.fn.foldlevel((vim.v.lnum < maxline) and (vim.v.lnum + 1 ) or maxline)
      self.icons = {
        foldclose = vim.opt_local.fillchars:get().foldclose,
        foldopen = vim.opt_local.fillchars:get().foldopen,
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
    condition = function (self)
      return self.width == 0
    end,
    provider = '',
  }, {
    condition = function (self)
      return self.foldclosed > 0 and self.foldclosed == vim.v.lnum
    end,
    provider = function (self)
      return self.icons.foldclose
    end,
  }, {
    condition = function (self)
      return self.foldlevel > self.foldlevel_before and self.foldlevel <= self.foldlevel_after
    end,
    provider = function (self)
      return self.icons.foldopen
    end,
  }, {
    provider = function ()
      return ' '
    end
  },
  hl = 'FoldColumn',
}

M.signs = {
  provider = '%s',
}

return M
