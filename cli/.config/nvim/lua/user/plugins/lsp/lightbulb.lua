local lsp_utils = require('user.plugins.lsp.utils')

local augroup = vim.api.nvim_create_augroup('user_lsp_lightbulb', { clear = true })
local namespace = vim.api.nvim_create_namespace('user_lsp_lightbulb')

local function has_action(responses)
  for _, response in ipairs(responses) do
    if response.result and not vim.tbl_isempty(response.result) then
      return true
    end
  end
  return false
end

local function response_handler(responses, line, bufnr)
  vim.api.nvim_buf_clear_namespace(bufnr, namespace, 0, -1)
  if has_action(responses) then
    vim.api.nvim_buf_set_extmark(bufnr, namespace, line, -1, { virt_text = {{ '', 'UserLightbulbExt' }}, hl_mode = 'combine' })
  end
end

local function check_action(args)
  local bufnr = args.buf
  local params = vim.lsp.util.make_range_params()
  params.context = { diagnostics = vim.lsp.diagnostic.get_line_diagnostics() }
  vim.lsp.buf_request_all(bufnr, 'textDocument/codeAction', params, function (responses)
    response_handler(responses, params.range.start.line, bufnr)
  end)
end

local function lsp_attach(args)
  local bufnr = args.buf
  if vim.b[bufnr].user_lsp_lightbulb_enabled or not lsp_utils.buf_supports_method(bufnr, 'textDocument/codeAction') then
    -- already setup or code actions not supported
    return
  end
  -- create CursorHold autocommands
  vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, { group = augroup, buffer = bufnr, callback = check_action })
  -- set enabled buffer flag
  vim.b[bufnr].user_lsp_lightbulb_enabled = true
end

local function lsp_detach(args)
  local bufnr = args.buf
  if lsp_utils.buf_supports_method(bufnr, 'textDocument/codeAction') then
    -- some client still supports code actions
    return
  end
  -- clear buffer autocommands
  vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
  -- set disabled buffer flag
  vim.b[bufnr].user_lsp_lightbulb_enabled = false
end

vim.api.nvim_create_autocmd('LspAttach', { group = augroup, callback = lsp_attach })
vim.api.nvim_create_autocmd('LspDetach', { group = augroup, callback = lsp_detach })
