let g:detectindent_preferred_indent = 4
let g:detectindent_min_indent = 2
let g:detectindent_max_indent = 8

augroup DetectIndent
	autocmd!
	autocmd BufReadPost *  DetectIndent
augroup END
