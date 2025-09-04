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

-- auto-chdir to project root
vim.api.nvim_create_autocmd('VimEnter', {
  group = augroup,
  callback = function ()
    local project_root = vim.fs.root(0, { '.git', '.venv', '.editorconfig' })
    if project_root then
      vim.fn.chdir(project_root)
    end
  end,
})

-- set vim.g.git_head if we're in a repo
vim.api.nvim_create_autocmd({ 'DirChanged', 'VimEnter', 'VimResume' }, {
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

-- restore cursor on start
vim.api.nvim_create_autocmd('BufReadPre', {
  group = augroup,
  callback = function (args)
    vim.api.nvim_create_autocmd('FileType', {
      buffer = args.buf,
      once = true,
      callback = function ()
        -- stop if not in a normal buffer
        if vim.bo.buftype ~= '' then
          return
        end
        -- stop if ignored filetype
        if vim.tbl_contains({ 'gitcommit', 'gitrebase' }, vim.bo.filetype) then
          return
        end
        -- stop if line was specified during start
        if vim.api.nvim_win_get_cursor(0)[1] > 1 then
          return
        end
        -- stop if restore mark is invalid
        local mark = vim.api.nvim_buf_get_mark(0, [["]])[1]
        if not (1 <= mark and mark <= vim.api.nvim_buf_line_count(0)) then
          return
        end
        -- restore cursor
        vim.cmd([[normal! g`"zv]])
      end,
    })
  end,
})

-- lint file
vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufWritePost' }, {
  group = augroup,
  callback = function ()
    require('lint').try_lint()
  end,
})
