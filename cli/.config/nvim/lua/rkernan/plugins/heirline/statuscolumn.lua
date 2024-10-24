local components = require('rkernan.plugins.heirline.components')
local conditions = require('heirline.conditions')
local utils = require('heirline.utils')

return {
  fallthrough = false,
  {
    condition = conditions.is_not_active,
    utils.surround({ '', ' '}, nil, components.column.folds),
    utils.surround({ '%=', '' }, nil, components.column.line_number),
    components.column.signs,
  }, {
    utils.surround({ '', ' '}, nil, components.column.folds),
    utils.surround({ '%=', '' }, nil, components.column.line_number),
    components.column.signs,
  }
}
