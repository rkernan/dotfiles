local cmdline = require('rkernan.ui.cmdline')
local messages = require('rkernan.ui.messages')

-- use custom ui_input
---@diagnostic disable-next-line: duplicate-set-field
vim.ui.input = function(...)
  -- TODO
end

-- use mini.pick for ui_select
---@diagnostic disable-next-line: duplicate-set-field
vim.ui.select = function (...)
  return require('mini.pick').ui_select(...)
end

local ns = vim.api.nvim_create_namespace('rkernan.ui')
vim.ui_attach(ns, { ext_cmdline = true, ext_messages = true }, function (event, ...)
  if event:match('^cmdline_') ~= nil then
    cmdline:handle(event, ...)
  elseif event:match('^msg_') ~= nil then
    messages:handle(event, ...)
  end
end)
