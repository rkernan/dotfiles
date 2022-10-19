local M = {}

local utils = require('user.utils')
local spinner = require('user.spinner')

local clients = {}

local function clean_stopped_clients()
  -- stop tracking any stopped clients
  for id, client in ipairs(clients) do
    if vim.lsp.client_is_stopped(id) then
      if client.spinner then
        client.spinner:stop()
      end
      table.remove(clients, id)
    end
  end
end

local function get_clients_by_bufnr(bufnr)
  local ids = {}
  for id, client in ipairs(clients) do
    if vim.tbl_contains(client.buffers, bufnr) then
      table.insert(ids, id)
    end
  end
  return ids
end

local function progress_callback(err, result, ctx)
  if not clients[ctx.client_id] then
    return
  end

  if result.value.kind == 'begin' then
    -- start tracking the job
    table.insert(clients[ctx.client_id].jobs, result.token)

    if not clients[ctx.client_id].spinner then
      vim.pretty_print(ctx.client_id)
      vim.pretty_print(clients[ctx.client_id].name)
      clients[ctx.client_id].spinner = spinner:new()
      vim.pretty_print(clients[ctx.client_id].spinner)
      clients[ctx.client_id].spinner:start()
    end

  elseif result.value.kind == 'end' then
    local job_index = utils.get_tbl_index(clients[ctx.client_id].jobs, result.token)
    -- stop tracking the job
    table.remove(clients[ctx.client_id].jobs, job_index)

    if vim.tbl_isempty(clients[ctx.client_id].jobs) and clients[ctx.client_id].spinner then
      -- stop spinner if not tracking any jobs
      clients[ctx.client_id].spinner:stop()
      clients[ctx.client_id].spinner = nil
    end
  end
end

function M.setup()
  -- register spinner callback
  vim.lsp.handlers['$/progress'] = progress_callback
end

function M.on_attach(client, bufnr)
  if not clients[client.id] then
    -- new client, add it
    clients[client.id] = {
      name = client.name,
      buffers = {},
      jobs = {},
      spinner = nil,
    }
  end

  -- add new buffer to client
  if not vim.tbl_contains(clients[client.id].buffers, bufnr) then
    table.insert(clients[client.id].buffers, bufnr)
  end
end

function M.status(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  clean_stopped_clients()

  local ids = get_clients_by_bufnr(bufnr)
  local status = ''

  for i, id in ipairs(ids) do
    status = string.format('%s%s', status, clients[id].name)
    if not vim.tbl_isempty(clients[id].jobs) then
      status = string.format('%s %s', status, clients[id].spinner:get())
    end

    if i < vim.tbl_count(ids) then
      status = string.format('%s ', status)
    end
  end

  return status
end

return M
