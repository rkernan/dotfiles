vim.keymap.set('n', '<Leader>t',
  function ()
    if vim.g.persistent_terminal_tabnr then
      vim.cmd(string.format('tabnext %d | startinsert', vim.g.persistent_terminal_tabnr))
      return
    end
    vim.cmd('tabnew | startinsert | terminal')
    local index = vim.fn.tabpagenr()
    vim.g.persistent_terminal_tabnr = index
    local bufnr = vim.fn.tabpagebuflist(index)[vim.fn.tabpagewinnr(index)]
    vim.keymap.set('t', '<A-i>', function ()
      local ok, _ = pcall(vim.cmd, 'tabnext #')
      if not ok then
        vim.cmd('1tabnext')
      end
    end, { buffer = bufnr })
    vim.api.nvim_create_autocmd('TabClosed', { buffer = bufnr, callback = function () vim.g.persistent_terminal_tabnr = nil end })
    vim.api.nvim_create_autocmd('TabEnter', { buffer = bufnr, callback = function () vim.cmd('startinsert') end })
  end,
  { desc = 'Persistent terminal' })

vim.api.nvim_create_autocmd('TabNew', { callback = function ()
  if vim.g.persistent_terminal_tabnr and vim.fn.tabpagenr() <= vim.g.persistent_terminal_tabnr then
    vim.g.persistent_terminal_tabnr = vim.g.persistent_terminal_tabnr + 1
  end
end })

vim.api.nvim_create_autocmd('TabClosed', { callback = function ()
  if vim.fn.tabpagenr('$') == 1 and vim.g.persistent_terminal_tabnr then
    vim.cmd('quit')
  end
  if vim.g.persistent_terminal_tabnr and vim.fn.tabpagenr() < vim.g.persistent_terminal_tabnr then
    vim.g.persistent_terminal_tabnr = vim.g.persistent_terminal_tabnr - 1
  end
end })
