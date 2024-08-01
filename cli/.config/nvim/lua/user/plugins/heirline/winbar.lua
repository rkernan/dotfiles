local components = require('user.plugins.heirline.components')
local conditions = require('heirline.conditions')

local buftype_disable = { 'nofile', 'help', 'prompt', 'quickfix', 'terminal' }
local filetype_disable = {}

-- need autocmd, otherwise an empty window appears until CursorMoved
local augroup = vim.api.nvim_create_augroup('plugins.heirline.winbar', { clear = true })
vim.api.nvim_create_autocmd('User', {
  pattern = 'HeirlineInitWinbar',
  callback = function (args)
    local buf = args.buf
    local buftype = vim.tbl_contains(buftype_disable, vim.bo[buf].buftype)
    local filetype = vim.tbl_contains(filetype_disable, vim.bo[buf].filetype)
    if buftype or filetype then
      vim.opt_local.winbar = nil
    end
  end,
  group = augroup,
})

return {
  hl = function ()
    if conditions.is_active() then
      return 'StatusLine'
    else
      return 'StatusLineNC'
    end
  end,
  fallthrough = false,
  {
    condition = function ()
      return conditions.buffer_matches({
        buftype = buftype_disable,
        filetype = filetype_disable,
      })
    end,
    init = function ()
      -- disable winbar
      vim.opt_local.winbar = nil
    end,
  }, {
    components.filename,
    components.space,
    components.gitsigns.added,
    components.gitsigns.changed,
    components.gitsigns.deleted,
    components.navic,
    components.fill,
    components.diagnostics.errors,
    components.diagnostics.warnings,
    components.diagnostics.info,
    components.diagnostics.hints,
    components.ruler,
  },
}
