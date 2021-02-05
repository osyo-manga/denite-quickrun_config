scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim



function! denite#quickrun_config#quickrun_config_all()
	return copy(extend(copy(g:quickrun#default_config), get(g:, "quickrun_config", {})))
endfunction


function! s:quickrun_config_type_bufnr(bufnr)
	let filetype = getbufvar(a:bufnr, "&filetype")
	let quickrun_config = getbufvar(a:bufnr, "quickrun_config")
	return empty(quickrun_config)
\		? s:quickrun_config_type_filetype(filetype)
\		: get(quickrun_config, "type", s:quickrun_config_type_filetype(filetype))
endfunction

function! s:quickrun_config_type_filetype(filetype)
	return get(get(denite#quickrun_config#quickrun_config_all(), a:filetype, {}), "type", a:filetype)
endfunction


function! denite#quickrun_config#gather_candidates()
	let filetype = &filetype
	return filter(denite#quickrun_config#quickrun_config_all(), "v:key =~# ('^'.filetype).'/'")
endfunction


function! denite#quickrun_config#config_type(...)
	let bufnr = a:0 && type(a:1) == type(0) ? a:1 : bufnr("%")
	return a:0 && type(a:1) == type("")
\		? s:quickrun_config_type_filetype(a:1)
\		: s:quickrun_config_type_bufnr(bufnr)
endfunction

function! denite#quickrun_config#set_local_quickrun_config(context)
	let bufnr = a:context["bufnr"]
	if empty(getbufvar(bufnr, "quickrun_config"))
		call setbufvar(bufnr, "quickrun_config", {})
	endif
	let config = getbufvar(bufnr, "quickrun_config")
	let config.type = a:context["targets"][0]["word"]
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
