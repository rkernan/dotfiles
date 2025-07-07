local add, now = MiniDeps.add, MiniDeps.now

add({ source = 'zenbones-theme/zenbones.nvim', depends = { 'rktjmp/lush.nvim' }})
now(function () vim.cmd.colorscheme('gruvbones') end)
