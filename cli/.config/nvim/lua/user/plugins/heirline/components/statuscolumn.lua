local M = {}

local conditions = require('heirline.conditions')

-- TODO click handlers
-- TODO helper utility to show specific extmark signs

M.lnum = { provider = '%=%{v:lnum} ' }
M.relnum = { provider = '%=%{v:relnum} ' }
M.signs = { provider = '%s' }
M.folds = { provider = '%C' }

return M
