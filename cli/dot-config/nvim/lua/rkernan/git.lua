local M = {}

---Get uo auto-command that sets vim.g.git_head to current git branch
function M.setup_head()
  local augroup = vim.api.nvim_create_augroup('rkernan.git', { clear = true })
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
end

return M
