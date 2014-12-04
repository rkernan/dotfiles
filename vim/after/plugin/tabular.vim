if !exists(':Tabularize')
	finish
endif

let s:save_cpo = &cpo
set cpo&vim

AddTabularPattern hash /:\zs
AddTabularPattern hash_rocket /=>
AddTabularPattern equals /=
AddTabularPattern comma /,\zs
AddTabularPattern backslash /\\

let &cpo = s:save_cpo
unlet s:save_cpo
