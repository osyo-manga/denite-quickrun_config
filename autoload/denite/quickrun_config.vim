scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim


function! denite#quickrun_config#config_type(...)
	let bufnr = a:0 && type(a:1) == type(0) ? a:1 : bufnr("%")
	return a:0 && type(a:1) == type("")
\		? s:quickrun_config_type_filetype(a:1)
\		: s:quickrun_config_type_bufnr(bufnr)
endfunction

function! denite#quickrun_config#quickrun_config_all()
	return copy(extend(copy(g:quickrun#default_config), get(g:, "quickrun_config", {})))
endfunction

function! denite#quickrun_config#set_local_quickrun_config(context)
	let g:debug = a:context
	
	let bufnr = a:context["bufnr"]
	if empty(getbufvar(bufnr, "quickrun_config"))
		call setbufvar(bufnr, "quickrun_config", {})
	endif
	let config = getbufvar(bufnr, "quickrun_config")
	let config.type = g:debug["targets"][0]["word"]
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
