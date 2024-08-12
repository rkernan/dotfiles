return {
  -- enabled = false,
  'luukvbaal/statuscol.nvim',
  lazy = false,
  config = function ()
    local builtin = require('statuscol.builtin')
    require('statuscol').setup({
      relculright = true,
      segments = {
        { sign = { name = { '.*' }, auto = true }, click = 'v:lua.ScSa' },
        { sign = { namespace = { 'diagnostic' }, auto = true }, click = 'v:lua.ScSa' },
        { text = { builtin.lnumfunc, ' ' }, click = 'v:lua.ScLa' },
        { sign = { namespace = { 'gitsigns' }, auto = true }, click = 'v:lua:ScSa' },
      }
    })
  end
}
