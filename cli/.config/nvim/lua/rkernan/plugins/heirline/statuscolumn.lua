local components = require('rkernan.plugins.heirline.components')
local conditions = require('heirline.conditions')
local utils = require('heirline.utils')

return {
  fallthrough = false,
  {
    condition = conditions.is_not_active,
    components.column.folds,
    components.column.diagnostics,
    utils.surround({ '%=', '' }, nil, components.column.line_number),
    components.column.gitsigns,
  }, {
    components.column.folds,
    components.column.diagnostics,
    utils.surround({ '%=', '' }, nil, components.column.line_number),
    components.column.gitsigns,
  }
}
