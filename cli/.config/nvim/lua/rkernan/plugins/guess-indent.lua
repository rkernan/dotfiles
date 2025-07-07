local add, later = MiniDeps.add, MiniDeps.later

add({ source = 'nmac427/guess-indent.nvim' })
later(function () require('guess-indent').setup() end)
