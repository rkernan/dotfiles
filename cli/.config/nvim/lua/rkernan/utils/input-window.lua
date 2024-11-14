local Window = require('rkernan.utils.window')

local namespace = vim.api.nvim_create_namespace('rkernan.utils.input-window')

local InputWindow = Window:subclass('InputWindow')

function InputWindow:initialize(win_opts, on_open)
  Window.initialize(
    self,
    vim.tbl_deep_extend('force',
      {
        relative = 'editor',
        zindex = 200,
        style = 'minimal',
        height = 1,
        width = 50,
        row = 0,
        col = 0,
      }, win_opts),
    function (window)
      -- common settings
      vim.api.nvim_set_option_value('buftype', 'nofile', { buf = window.bufnr })
      vim.api.nvim_set_option_value('bufhidden', 'wipe', { buf = window.bufnr })
      vim.api.nvim_set_option_value('winfixbuf', true, { win = window.winnr })
      vim.api.nvim_set_option_value('virtualedit', 'all,onemore', { win = window.winnr })
      -- trigger on_open parameter
      if on_open then
        on_open(window)
      end
    end
  )
  self.extmark_id = nil
end

function InputWindow:update(prompt, default_text, position, win_opts)
  self:open(win_opts)

  -- set prompt virtual text
  self.extmark_id = vim.api.nvim_buf_set_extmark(self.bufnr, namespace, 0, 0, {
    id = self.extmark_id,
    right_gravity = false,
    virt_text_pos = 'inline',
    virt_text = {{ prompt, 'NormalFloat' }},
  })
  -- set default text
  vim.api.nvim_buf_set_lines(self.bufnr, -2, -1, false, { default_text })
  -- set cursor position
  vim.api.nvim_win_set_cursor(self.winnr, position)
  -- TODO update window row/col/height/width?

  vim.api.nvim__redraw({ cursor = true, flush = true, win = self.winnr })
end

return InputWindow
