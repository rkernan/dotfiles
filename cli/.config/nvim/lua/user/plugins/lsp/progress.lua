local spinner = require('user.spinner')
local utils = require('user.utils')
local augroup = vim.api.nvim_create_augroup('user_lsp_progress', { clear = true })

Client = {
  id = nil,
  name = nil,
  buffers = {},
  jobs = {},
  spinner = nil,
}

function Client:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function Client:is_tracking(bufnr)
  -- Check if tracking buffer.
  return vim.tbl_contains(self.buffers, bufnr)
end

function Client:is_tracking_any()
  -- Check if tracking nay buffers.
  return not vim.tbl_isempty(self.buffers)
end

function Client:start_tracking(bufnr)
  -- Start tracking buffer.
  if vim.tbl_contains(self.buffers, bufnr) and self:is_tracking(bufnr) then
    return
  end
  table.insert(self.buffers, bufnr)
end

function Client:stop_tracking(bufnr)
  -- Stop tracking given buffer.
  idx = utils.tbl_index(self.buffers, bufnr)
  if idx then
    table.remove(self.buffers, idx)
  end
end

function Client:has_running_jobs()
  -- Check for running jobs.
  return not vim.tbl_isempty(self.jobs)
end

function Client:start_job(job)
  -- Start a job.
  if vim.tbl_contains(self.jobs, job) then
    return
  end
  table.insert(self.jobs, job)
end

function Client:stop_job(job)
  -- Stop a job.
  local idx = utils.tbl_index(self.jobs, job)
  if idx then
    table.remove(self.jobs, idx)
  end
end

function Client:start_spinner()
  -- Start spinner animation.
  if not self.spinner  then
    self.spinner = spinner:new()
    self.spinner:start()
  end
end

function Client:stop_spinner()
  -- Stop spinner animation.
  if self.spinner then
    self.spinner:stop()
    self.spinner = nil
  end
end

function Client:get_spinner_frame()
  -- Get current spinner animation.
  if not self.spinner then
    return ''
  end
  return self.spinner:get()
end

ClientsTracker = {
  clients = {}
}

function ClientsTracker:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function ClientsTracker:has(client_id)
  -- Check if currently tracking a client.
  return self.clients[client_id] ~= nil
end

function ClientsTracker:get(client_id)
  -- Get tracked client or nil.
  return self.clients[client_id]
end

function ClientsTracker:get_by_bufnr(bufnr)
  -- Get all clients for a given buffer.
  local clients = {}
  for _, client in ipairs(self.clients) do
    if client:is_tracking(bufnr) then
      table.insert(clients, client)
    end
  end
  return clients
end

function ClientsTracker:start_tracking(client_id, bufnr)
  -- Start tracking the client for a given buffer.
  if not self:has(client_id) then
    local client = vim.lsp.get_client_by_id(client_id)
    self.clients[client_id] = Client:new({ id = client_id, name = client.name })
  end

  self.clients[client_id]:start_tracking(bufnr)
end

function ClientsTracker:stop_tracking(client_id, bufnr)
  -- Stop tracking the client for a given buffer.
  -- Remove client if it has no buffers.
  if not self:has(client_id) then
    return
  end

  self.clients[client_id]:stop_tracking(bufnr)

  if not self.clients[client_id]:is_tracking_any() then
    self.clients[client_id]:stop_spinner()
    self.clients[client_id] = nil
  end
end

local tracker = ClientsTracker:new()

local function lsp_attach(args)
  -- Start tracking the client and buffer.
  -- autocmd: LspAttach
  local bufnr = args.buf
  local client_id = args.data.client_id
  tracker:start_tracking(client_id, bufnr)
end

local function lsp_detach(args)
  -- Stop tracking the buffer client.
  -- autocmd: LspDetach
  local bufnr = args.buf
  local client_id = args.data.client_id
  tracker:stop_tracking(client_id, bufnr)
end

local function buf_delete(args)
  -- Stop tracking all clients attached to buffer.
  -- autocmd: BufDelete
  local bufnr = args.buf
  for _, client in ipairs(tracker:get_by_bufnr(bufnr)) do
    tracker:stop_tracking(client.id, bufnr)
  end
end

local function progress_callback(_, result, ctx)
  local job = result.token
  local client_id = ctx.client_id
  local client = tracker:get(client_id)

  if result.value.kind == 'begin' then
    client:start_job(job)
    client:start_spinner()
  elseif result.value.kind == 'end' then
    client:stop_job(job)
    if not client:has_running_jobs() then
      client:stop_spinner()
    end
  end
end

-- TODO LspProgressUpdate?
vim.lsp.handlers['$/progress'] = progress_callback
vim.api.nvim_create_autocmd('LspAttach', { group = augroup, callback = lsp_attach })
vim.api.nvim_create_autocmd('LspDetach', { group = augroup, callback = lsp_detach })
vim.api.nvim_create_autocmd('BufDelete', { group = augroup, callback = buf_delete })

local M = {}

function M.progres_status(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  local clients = tracker:get_by_bufnr(bufnr)

  local status = ''
  for _, client in ipairs(clients) do
    status = vim.trim(string.format('%s %s %s', status, client.name, client:get_spinner_frame()))
  end

  return status
end

return M
