local cmdline = require('rkernan.ui.cmdline')
local input = require('rkernan.ui.input')
local messages = require('rkernan.ui.messages')

-- use custom ui_input
---@diagnostic disable-next-line: duplicate-set-field
vim.ui.input = input.input

-- use mini.pick for ui_select
---@diagnostic disable-next-line: duplicate-set-field
vim.ui.select = function (...)
  return require('mini.pick').ui_select(...)
end

local namespace = vim.api.nvim_create_namespace('rkernan.ui')
vim.ui_attach(namespace, { ext_cmdline = true, ext_messages = true }, function (event, ...)
  if event:match('^cmdline_') ~= nil then
    cmdline:handle(event, ...)
  elseif event:match('^msg_') ~= nil then
    messages:handle(event, ...)
  end
end)
