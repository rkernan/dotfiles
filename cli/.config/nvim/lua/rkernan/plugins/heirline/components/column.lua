local M = {}

local ffi = require('ffi')

ffi.cdef([[
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

return M
