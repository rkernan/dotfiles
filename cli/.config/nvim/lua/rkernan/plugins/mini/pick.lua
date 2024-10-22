local keys = {
  { '<Leader>f', function () require('mini.pick').builtin.files() end, desc = 'Files' },
  { '<Leader>pf', function () require('mini.extra').pickers.git_files() end, desc = 'Git files' },
  { '<Leader>b', function () require('mini.pick').builtin.buffers() end, desc = 'Buffers' },
  { '<Leader>/', function () require('mini.pick').builtin.grep_live() end, desc = 'Live grep' },
  { '<Leader>e', function () require('mini.extra').pickers.diagnostic({ scope = 'current' }) end, desc = 'Diagnostics' },
  { '<Leader>E', function () require('mini.extra').pickers.diagnostic({ scope = 'all' }) end, desc = 'Workspace diagnostics' },
}

local function setup()
  require('mini.pick').setup()
end


return { keys = keys, setup = setup }
