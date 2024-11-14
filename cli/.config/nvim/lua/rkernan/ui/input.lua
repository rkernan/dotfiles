local M = {}
local Window = require('rkernan.utils.window')

local namespace = vim.api.nvim_create_namespace('rkernan.ui.input')

local InputWindow = Window:subclass('InputWindow')

function InputWindow:initialize(prompt, on_confirm)
  Window.initialize(
    self,
    {
      relative = 'editor',
      zindex = 200,
      width = 50,
      height = 1,
      style = 'minimal',
      border = 'single',
    },
    function (window)
      vim.api.nvim_buf_set_name(window.bufnr, 'input')
      vim.api.nvim_set_option_value('buftype', 'prompt', { buf = window.bufnr })
      vim.api.nvim_set_option_value('bufhidden', 'wipe', { buf = window.bufnr })
      vim.api.nvim_set_option_value('winfixbuf', true, { win = window.winnr })
      vim.api.nvim_set_option_value('virtualedit', 'all,onemore', { win = window.winnr })
    end
  )
  self.prompt = prompt or ''
  self.on_confirm = on_confirm
end

function InputWindow:open(default_text)
  default_text = default_text or ''
  -- Window.open(self, { row = vim.o.lines / 2 + 1, col = vim.o.columns / 2 - 25 })
  Window.open(self, { row = vim.o.lines / 2, col = vim.o.columns / 2 })

  vim.api.nvim_buf_set_extmark(self.bufnr, namespace, 0, 0, {
    right_gravity = false,
    virt_text_pos = 'inline',
    virt_text = {{ self.prompt, 'NormalFloat' }},
  })

  local width = math.max(50, #self.prompt + 20)
  vim.api.nvim_win_set_config(self.winnr, { width = width })
  vim.notify(default_text)
  vim.api.nvim_buf_set_lines(self.bufnr, -2, -1, false, { default_text })
  vim.api.nvim_win_set_cursor(self.winnr, { 1, #self.prompt + #default_text })

  vim.fn.prompt_setprompt(self.bufnr, self.prompt)
  -- FIXME why defer?
  vim.fn.prompt_setcallback(self.bufnr, function (str) vim.defer_fn(function () self.on_confirm(str) end, 10) end)

  vim.keymap.set({ 'i', 'n' }, '<CR>', '<CR><Esc>:close!<CR>:stopinsert<CR>', { silent = true, buffer = self.bufnr })
  vim.keymap.set('n', '<Esc>', function () return vim.fn.mode() == 'n' and 'ZQ' or '<Esc>' end, { expr = true, silent = true, buffer = self.bufnr })
  vim.keymap.set('n', 'q', function () return vim.fn.mode() == 'n' and 'ZQ' or '<Esc>' end, { expr = true, silent = true, buffer = self.bufnr })
  -- vim.cmd.startinsert()

  vim.api.nvim__redraw({ cursor = true, flush = true, win = self.winnr })
end

-- local function wininput(opts, on_confirm, win_opts)
--   local bufnr = vim.api.nvim_create_buf(false, false)
--   vim.api.nvim_set_option_value('buftype', 'prompt', { buf = bufnr })
--   vim.api.nvim_set_option_value('bufhidden', 'wipe', { buf = bufnr })
--
--   local prompt = opts.prompt or ''
--   local default_text = opts.default or ''
--
--   -- set prompt and callback (CR) for prompt buffer
--   vim.fn.prompt_setprompt(bufnr, prompt)
--   vim.fn.prompt_setcallback(bufnr, function (input) vim.defer_fn(function () on_confirm(input) end, 10) end)
--
--   vim.keymap.set({ 'i', 'n' }, '<CR>', '<CR><Esc>:close!<CR>:stopinsert<CR>', { silent = true, buffer = bufnr })
--   vim.keymap.set('n', '<Esc>', function () return vim.fn.mode() == 'n' and 'ZQ' or '<Esc>' end, { expr = true, silent = true, buffer = bufnr })
--   vim.keymap.set('n', 'q', function () return vim.fn.mode() == 'n' and 'ZQ' or '<Esc>' end, { expr = true, silent = true, buffer = bufnr })
--
--   local default_win_opts = {
--     relative = 'editor',
--     row = vim.o.lines / 2 - 1,
--     col = vim.o.columns / 2 - 25,
--     width = 50,
--     height = 1,
--     focusable = true,
--     style = 'minimal',
--     border = 'single',
--   }
--
--   win_opts = vim.tbl_deep_extend('force', default_win_opts, win_opts)
--   -- adjust window width so there's always space for prompt + default text
--   win_opts.width = math.max(#default_text + #prompt + 5, win_opts.width)
--
--   local winnr = vim.api.nvim_open_win(bufnr, true, win_opts)
--   vim.api.nvim_buf_set_text(bufnr, 0, #prompt, 0, #prompt, { default_text })
--   vim.api.nvim_win_set_cursor(winnr, { 1, #prompt + 1 })
--   vim.cmd.startinsert()
-- end

function M.input(opts, on_confirm)
  InputWindow:new(opts.prompt, on_confirm):open(opts.default)
end

return M
