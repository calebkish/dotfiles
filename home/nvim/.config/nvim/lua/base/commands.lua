-- vim.api.nvim_create_augroup()

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

]])

vim.api.nvim_create_user_command('JSONFormat', function(args)
    local range = args.line1 .. ',' .. args.line2
    local filter_cmd = '!' -- See `:help range!`
    local shell_cmd = 'python -m json.tool'
    vim.cmd(range .. filter_cmd .. shell_cmd)
end, { nargs = 0, range = true })
