let g:vimspector_install_gadgets = [ 'netcoredbg' ]

fun! GotoWindow(id)
    call win_gotoid(a:id)
    "MaximizerToggle
endfun

nnoremap <localleader>m :MaximizerToggle!<CR>
nnoremap <localleader>dd :call vimspector#Launch()<CR>
nnoremap <localleader>dc :call GotoWindow(g:vimspector_session_windows.code)<CR>
nnoremap <localleader>dt :call GotoWindow(g:vimspector_session_windows.tagpage)<CR>
nnoremap <localleader>dv :call GotoWindow(g:vimspector_session_windows.variables)<CR>
nnoremap <localleader>dw :call GotoWindow(g:vimspector_session_windows.watches)<CR>
nnoremap <localleader>ds :call GotoWindow(g:vimspector_session_windows.stack_trace)<CR>
nnoremap <localleader>do :call GotoWindow(g:vimspector_session_windows.output)<CR>
nnoremap <localleader>de :call vimspector#Reset()<CR>

nnoremap <localleader>dtcb :call vimspector#CleanLineBreakpoint()<CR>

nnoremap <silent><localleader>l :call vimspector#StepInto()<CR>
nnoremap <silent><localleader>j :call vimspector#StepOver()<CR>
nnoremap <silent><localleader>k :call vimspector#StepOut()<CR>
nnoremap <silent><localleader>d_ :call vimspector#Restart()<CR>
nnoremap <silent><localleader>d<space> :call vimspector#Continue()<CR>

nnoremap <silent><localleader>c :call vimspector#RunToCursor()<CR>
nnoremap <silent><localleader>b :call vimspector#ToggleBreakpoint()<CR>
nnoremap <silent><localleader>dbc :call vimspector#ToggleConditionalBreakpoint()<CR>
