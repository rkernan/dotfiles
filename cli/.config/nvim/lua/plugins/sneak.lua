vim.api.nvim_set_keymap('', 'f', '<Plug>Sneak_f', {})
vim.api.nvim_set_keymap('', 'F', '<Plug>Sneak_F', {})
vim.api.nvim_set_keymap('', 't', '<Plug>Sneak_t', {})
vim.api.nvim_set_keymap('', 'T', '<Plug>Sneak_T', {})

vim.g['sneak#s_next'] = 1

local no_unicode = tonumber(os.getenv('NO_UNICODE'))
if no_unicode then
  vim.g['sneak#prompt'] = '>'
else
  vim.g['sneak#prompt'] = '❯'
end
