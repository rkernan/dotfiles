local components = require('rkernan.heirline.components')
local conditions = require('heirline.conditions')
local utils = require('heirline.utils')

return {
  fallthrough = false,
  {
    condition = conditions.is_not_active,
    components.column.folds,
    utils.surround({ '%=', '' }, nil, components.column.line_number),
    components.column.signs,
  }, {
    components.column.folds,
    utils.surround({ '%=', '' }, nil, components.column.line_number),
    components.column.signs,
  }
}
