vim.cmd([[
function! TabsSet()
  echohl Question
  let l:tabstop = 1 * input('setlocal tabstop = softtabstop = shiftwidth = ')
  let l:et = input('setlocal expandtab [y/N] ')
  echohl None
  if l:tabstop > 0
    let &l:ts = l:tabstop
    let &l:sts = l:tabstop
    let &l:sw = l:tabstop
  endif
  if l:et == "y"
    setlocal expandtab
  else
    setlocal noexpandtab
  end
  echo
  echo "\r"
  call TabsSummarize()
endfunction

function! TabsSummarize()
  try
    echomsg 'tabstop=' . &l:ts . ' softtabstop=' . &l:sts . ' shiftwidth=' . &l:sw . ' ' . ((&l:et) ? 'expandtab' : 'noexpandtab')
  endtry
endfunction

command! -nargs=0 SetTabs call TabsSet()
command! -nargs=0 SummarizeTabs call TabsSummarize()
]])
