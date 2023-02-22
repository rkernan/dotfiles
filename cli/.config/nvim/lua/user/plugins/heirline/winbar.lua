local components = require('user.plugins.heirline.components')

return {
  components.file.name,
  components.git.diff,
  components.navic,
  components.align,
  components.diagnostics,
  components.ruler,
}
