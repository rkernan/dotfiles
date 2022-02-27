vim.g['modestatus#statusline'] = {
  { 'mode' },
  { 'fugitive_branch', 'signify_added', 'signify_modified', 'signify_removed' },
  'filename', 'modified', 'readonly',
  '%<', '%=',
  { 'coc_errors', 'coc_warnings' },
  'filetype', 'encoding', 'bomb', 'fileformat',
  { 'line', 'column', 'line_percent' }}
vim.g['modestatus#statusline_override_fugitiveblame'] = {
  'filetype', '%=',
  { 'line', 'line_max', 'line_percent'}}
vim.g['modestatus#statusline_override_qf'] = {
  { 'mode' },
  'buftype', 'filetype', '%=',
  { 'line', 'line_max', 'line_percent' }}

vim.cmd([[
augroup modestatus_custom
  autocmd!
  autocmd FileType fugitiveblame silent! call modestatus#setlocal('fugitiveblame')
  autocmd FileType qf silent! call modestatus#setlocal('qf')
augroup END

silent! call modestatus#options#add('mode', 'color', 'ModestatusMode')

silent! call modestatus#options#add('fugitive_branch', 'color', ['Modestatus2', 'Modestatus2NC'])
silent! call modestatus#options#add('signify_added', 'color', ['Modestatus2Green', 'Modestatus2NCGreen'])
silent! call modestatus#options#add('signify_modified', 'color', ['Modestatus2Aqua', 'Modestatus2NCAqua'])
silent! call modestatus#options#add('signify_removed', 'color', ['Modestatus2Red', 'Modestatus2NCRed'])

silent! call modestatus#options#add('filename_short', 'color', ['ModestatusBold', 'ModestatusNC'])
silent! call modestatus#options#add('modified', 'color', ['ModestatusRedBold', 'ModestatusNCRedBold'])
silent! call modestatus#options#add('readonly', 'color', ['ModestatusRed', 'ModestatusNCRed'])

silent! call modestatus#options#add('filetype', 'format', '%s')
silent! call modestatus#options#add('encoding', 'format', '%s')
silent! call modestatus#options#add('encoding', 'separator', '')
silent! call modestatus#options#add('bomb', 'format', '-%s')
silent! call modestatus#options#add('bomb', 'separator', '')
silent! call modestatus#options#add('fileformat', 'format', '[%s]')

silent! call modestatus#options#add('line', 'color', ['Modestatus2', 'Modestatus2NC'])
silent! call modestatus#options#add('line', 'separator', '')
silent! call modestatus#options#add('column', 'format', ',%s')
silent! call modestatus#options#add('column', 'color', ['Modestatus2', 'Modestatus2NC'])
silent! call modestatus#options#add('line_max', 'format', '/%s')
silent! call modestatus#options#add('line_max', 'color', ['Modestatus2', 'Modestatus2NC'])
silent! call modestatus#options#add('line_percent', 'color', ['Modestatus2', 'Modestatus2NC'])

silent! call modestatus#options#add('coc_errors', 'color', ['ModestatusCocError', 'ModestatusCocError'])
silent! call modestatus#options#add('coc_warnings', 'color', ['ModestatusCocWarning', 'ModestatusCocWarning'])
]])
