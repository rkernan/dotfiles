local augroup = vim.api.nvim_create_augroup('rkernan.autocmds', { clear = true })

-- highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function ()
    (vim.hl or vim.highlight).on_yank()
  end,
  group = augroup,
})

-- auto create dir when saving
vim.api.nvim_create_autocmd('BufWritePre', {
  callback = function (event)
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
  end,
  group = augroup,
})

-- automatic insert mode in terminals
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

-- auto-open quickfix
vim.api.nvim_create_autocmd('QuickFixCmdPost', {
  group = augroup,
  pattern = '[^l]*',
  callback = function () vim.cmd.cwindow() end
})

-- auto-open loclist
vim.api.nvim_create_autocmd('QuickFixCmdPost', {
  group = augroup,
  pattern = 'l*',
  callback = function () vim.cmd.lwindow() end,
})

-- auto-polulate loclist with diagnostics
vim.api.nvim_create_autocmd('DiagnosticChanged', {
  group = augroup,
  callback = function ()
    vim.diagnostic.setloclist({ open = false })
  end,
})

--- auto-set vim.g.git_head
vim.api.nvim_create_autocmd({ 'DirChanged', 'VimEnter', 'VimResume' }, {
  group = augroup,
  callback = function ()
    if require('mini.misc').find_root(0, { '.git' }) then
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

vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufWritePost' }, {
  group = augroup,
  callback = function ()
    require('lint').try_lint()
  end,
})

local statusline = require('rkernan.statusline')
statusline.setup_colors()
statusline.setup_redraw()
statusline.setup_winbar()

local mini_misc = require('mini.misc')
mini_misc.setup_auto_root({ '.git', '.venv', '.editorconfig' })
mini_misc.setup_restore_cursor()
