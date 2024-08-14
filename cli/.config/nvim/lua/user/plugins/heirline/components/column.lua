local M = {}

local ffi = require('ffi')

ffi.cdef([[
  typedef struct {} Error;
  typedef struct {} win_T;
  win_T *find_window_by_handle(int Window, Error *err);
  int compute_foldcolumn(win_T *wp, int col);
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
  provider = '%l ',
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
  },
}

M.folds = {
  fallthrough = false,
  static = {
    icons = {
      foldclose = vim.opt_local.fillchars:get().foldclose,
      foldopen = vim.opt_local.fillchars:get().foldopen,
    },
  },
  init = function (self)
    -- calculate fold column width
    local wp = ffi.C.find_window_by_handle(0, ffi.new 'Error')
    self.width = ffi.C.compute_foldcolumn(wp, 0)

    if self.width > 0 then
      self.foldclosed = vim.fn.foldclosed(vim.v.lnum)
      self.foldlevel = vim.fn.foldlevel(vim.v.lnum)
      self.foldlevel_before = vim.fn.foldlevel((vim.v.lnum > 1) and (vim.v.lnum - 1) or 1)
      local maxline = vim.fn.line('$')
      self.foldlevel_after = vim.fn.foldlevel((vim.v.lnum < maxline) and (vim.v.lnum + 1 ) or maxline)
    else
      self.foldclosed = 0
      self.foldlevel = 0
      self.foldlevel_before = 0
      self.foldlevel_after = 0
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
      return self.icons.foldclose .. (' '):rep(self.width - #self.icons.foldclose)
    end,
  }, {
    condition = function (self)
      return self.foldlevel > self.foldlevel_before and self.foldlevel <= self.foldlevel_after
    end,
    provider = function (self)
      return self.icons.foldopen .. (' '):rep(self.width - #self.icons.foldopen)
    end,
  }, {
    provider = function (self)
      return (' '):rep(self.width)
    end
  },
  hl = 'FoldColumn',
}

M.signs = {
  provider = '%s',
}

-- M.folds = {
--   -- TODO click handler
--   fallthrough = false,
--   init = function (self)
--     self.foldlevel = vim.fn.foldlevel(vim.v.lnum)
--     self.foldlevel_before = vim.fn.foldlevel((vim.v.lnum > 1) and (vim.v.lnum - 1) or 1)
--     local maxline = vim.fn.line('$')
--     self.foldlevel_after = vim.fn.foldlevel((vim.v.lnum < maxline) and (vim.v.lnum + 1 ) or maxline)
--     self.foldclosed = vim.fn.foldclosed(vim.v.lnum)
--   end,
--   hl = 'FoldColumn',
--   {
--     condition = function (self)
--       return self.foldclosed > 0 and self.foldclosed == vim.v.lnum
--     end,
--     provider = '',
--     on_click = {
--       update = true,
--       name = 'foldcolumn_open_click',
--       callback = function (...)
--         vim.cmd([[norm! zo]])
--       end,
--     },
--   }, {
--     condition = function (self)
--       return self.foldlevel > self.foldlevel_before and self.foldlevel <= self.foldlevel_after
--     end,
--     provider = '',
--     on_click = {
--       -- update = true,
--       name = 'foldcolumn_close_click',
--       callback = function (...)
--         vim.cmd([[norm! zc]])
--       end,
--     }
--   },
-- }

-- local function signs_from_namespace(namespace)
--   return {
--     static = {
--       namespace = namespace,
--       namespace_id = nil,
--       exmarks = {},
--     },
--     init = function (self)
--       for name, namespace_id in pairs(vim.api.nvim_get_namespaces()) do
--         if string.match(name, self.namespace) then
--           self.namespace_id = namespace_id
--           break
--         end
--       end
--       if self.namespace_id then
--         self.exmarks = vim.api.nvim_buf_get_extmarks(0, self.namespace_id, { vim.v.lnum - 1, 0 }, { vim.v.lnum - 1, -1 }, { type = 'sign', details = true })
--       end
--     end,
--   }
-- end
--
-- M.gitsigns = utils.insert(signs_from_namespace('gitsigns_signs'), {
--   {
--     fallthrough = false,
--     {
--       condition = function (self)
--         return conditions.is_git_repo() and #self.exmarks > 0
--       end,
--       provider = function (self)
--         return string.format('%s ', self.exmarks[1][4].sign_text:gsub('%s+', ''))
--       end,
--       hl = function (self)
--         return self.exmarks[1][4].sign_hl_group
--       end,
--     }, {
--       provider = '  ',
--     },
--   },
-- })
--
-- M.diagnostics = utils.insert(signs_from_namespace('diagnostic/signs'), {
--   {
--     fallthrough = false,
--     {
--       condition = conditions.has_diagnostics,
--       provider = function (self)
--         return string.format('%s', self.exmarks[1][4].sign_text:gsub('%s+', ''))
--       end,
--       hl = function (self)
--         return self.exmarks[1][4].sign_hl_group
--       end,
--     }, {
--       provider = ' ',
--     }
--   }
-- })

return M
