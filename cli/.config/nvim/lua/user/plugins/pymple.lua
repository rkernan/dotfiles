return {
  {
    'alexpasmantier/pymple.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      -- optional (nicer ui)
      'stevearc/dressing.nvim',
      -- provided by mini.icons
      -- 'nvim-tree/nvim-web-devicons',
    },
    build = ':PympleBuild',
    ft = 'python',
    config = true,
  }
}
