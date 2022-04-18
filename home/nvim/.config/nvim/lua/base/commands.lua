vim.cmd([[

augroup file_format_options
    autocmd!
    autocmd FileType * setlocal formatoptions-=t formatoptions-=r formatoptions-=o
augroup END

augroup return_to_last_position_in_file
    autocmd!
    autocmd BufReadPost *
        \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
        \ |   exe "normal! g`\""
        \ | endif
augroup END

augroup set_two_space_tabs
    autocmd!
    autocmd Filetype html,css,scss,typescript,javascript,json setlocal tabstop=2
augroup END

augroup markdown_autocmd
    autocmd!
    autocmd Filetype markdown syntax off
    autocmd Filetype markdown TSDisable highlight
augroup END

command! -range JSONFormat <line1>,<line2>!python -m json.tool

]])
