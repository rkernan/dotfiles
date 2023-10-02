return {
  'luukvbaal/statuscol.nvim',
  lazy = false,
  config = function ()
    local builtin = require('statuscol.builtin')
    require('statuscol').setup({
      relculright = true,
      segments = {
        { sign = { name = { '.*' }, auto = true }, click = 'v:lua.ScSa' },
        { sign = { name = { 'Diagnostic.*' }, auto = true }, click = 'v:lua.ScSa' },
        { sign = { name = { 'GitSigns.*' }, colwidth = 1, auto = true }, click = 'v:lua.ScSa' },
        { text = { builtin.lnumfunc }, click = 'v:lua.ScLa' },
        { text = { ' ', builtin.foldfunc, ' ' }, { builtin.not_empty, true, builtin.not_empty }, click = 'v:lua.ScFa' },
      }
    })
  end
}
