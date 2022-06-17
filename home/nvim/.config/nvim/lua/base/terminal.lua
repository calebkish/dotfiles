vim.cmd([[
" Use to open terminal.
function! OpenTerminal()
    split term://zsh
    resize 10
endfunction
nnoremap <silent><leader>t :call OpenTerminal()<CR>

function! TerminalOptions()
    augroup terminal_opts
        autocmd!
        autocmd BufEnter <buffer> silent! exec "normal! i"
    augroup
endfunction

augroup terminal_open
    autocmd!
    autocmd TermOpen * call TerminalOptions()
augroup

" Exit out of terminal.
tnoremap <C-q> <C-\><C-n>:q!<CR>

" Easily navigate between terminal and other panes.
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

tnoremap <C-n> <C-\><C-n>
]])
