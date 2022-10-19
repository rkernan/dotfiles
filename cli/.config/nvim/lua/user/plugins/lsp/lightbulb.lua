local M = {}

local icon = ''
local hl = 'WarningMsg'
local ns = vim.api.nvim_create_namespace('user.plugins.lsp.lightbulb')

local function has_action(responses)
  for _, response in ipairs(responses) do
    if response.result and not vim.tbl_isempty(response.result) then
      return true
    end
  end
  return false
end

local function response_handler(responses, line, bufnr)
  vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)

  if has_action(responses) then
    vim.api.nvim_buf_set_extmark(bufnr, ns, line, -1, { virt_text = {{ icon, hl }}, hl_mode = 'combine' })
  end
end

local function check_action()
  local params = vim.lsp.util.make_range_params()
  params.context = { diagnostics = vim.lsp.diagnostic.get_line_diagnostics() }
  local bufnr = vim.api.nvim_get_current_buf()
  vim.lsp.buf_request_all(bufnr, 'textDocument/codeAction', params, function (responses)
    response_handler(responses, params.range.start.line, bufnr)
  end)
end

function M.on_attach(client, bufnr)
  if not client.supports_method('textDocument/codeAction') then
    return
  end

  local group = vim.api.nvim_create_augroup('user.plugins.lsp.lightbulb', { clear = false })
  vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
  vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, { buffer = bufnr, group = group, callback = function () check_action() end })
end

return M
