local augroup = vim.api.nvim_create_augroup('rkernan.autocmds', { clear = true })

-- automatic insert mode in terms
vim.api.nvim_create_autocmd({ 'TermOpen', 'BufEnter' }, { group = augroup, pattern = 'term://*', command = [[startinsert]] })

-- resize windows automatically
vim.api.nvim_create_autocmd('VimResized', { group = augroup, command = [[wincmd =]] })

-- disable hlsearch on cursor move
vim.api.nvim_create_autocmd('CursorMoved', {
  group = augroup,
  callback = function ()
    if vim.v.hlsearch and vim.fn.searchcount().exact_match == 0 then
      vim.schedule(function ()
        vim.cmd.nohlsearch()
        vim.api.nvim_exec_autocmds('User', { pattern = 'HlSearchDisabled' })
      end
      )
    end
  end,
})

-- set vim.g.git_head if we're in a repo
vim.api.nvim_create_autocmd({ 'DirChanged', 'SessionLoadPost', 'TabEnter', 'VimEnter', 'VimResume' }, {
  group = augroup,
  callback = function ()
    if vim.fs.root(0, '.git') then
      local cmd = { 'git', '--no-pager', '--no-optional-locks', '--literal-pathspecs', '-c', 'gc.auto=0', 'rev-parse' }
      vim.g.git_head = vim.system(vim.list_extend(cmd, { '--abbrev-ref', 'HEAD' }), { text = true }):wait().stdout:gsub('%s+', '')
      if vim.g.git_head == 'HEAD' then
        vim.g.git_head = vim.system(vim.list_extend(cmd, { '--short', 'HEAD' }), { text = true }):wait().stdout:gsub('%s+', '')
      end
    else
      vim.g.git_head = nil
    end

    vim.api.nvim_exec_autocmds('User', { pattern = 'GitHeadUpdate' })
  end,
})

require('mini.misc').setup_auto_root({ '.venv', '.git' })
require('mini.misc').setup_restore_cursor()

vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufWritePost' }, {
  group = augroup,
  callback = function ()
    require('lint').try_lint()
  end,
})
