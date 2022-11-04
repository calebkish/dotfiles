
-- =============================================================================
-- Auto-commands
-- =============================================================================

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
    autocmd Filetype html,css,scss,typescript,typescriptreact,javascript,json setlocal tabstop=2
augroup END

]])


-- =============================================================================
-- Commands
-- =============================================================================

-- Format JSON in selection range
vim.api.nvim_create_user_command('JSONFormat', function(args)
    local range = args.line1 .. ',' .. args.line2
    local filter_cmd = '!' -- See `:help range!`
    local shell_cmd = 'python -m json.tool'
    vim.cmd(range .. filter_cmd .. shell_cmd)
end, { nargs = 0, range = true })

vim.cmd([[
command! -nargs=1 -complete=command Redir
      \ :execute "new | put=execute(\'" . <q-args> . "\') | setl nomodified"
]])


-- View command output in a scratch window.
vim.cmd([[
function! s:Scratch (command, ...)
   redir => lines
   let saveMore = &more
   set nomore
   execute a:command
   redir END

   let &more = saveMore

   call feedkeys("\<cr>")

   new | setlocal buftype=nofile bufhidden=hide noswapfile

   put=lines

   if a:0 > 0
      execute 'vglobal/'.a:1.'/delete'
   endif
   if a:command == 'scriptnames'
      %substitute#^\[\[:space:\]\]*\[\[:digit:\]\]\+:\[\[:space:\]\]*##e
   endif
   silent %substitute/\%^\_s*\n\|\_s*\%$
   let height = line('$') + 3
   execute 'normal! z'.height."\<cr>"
   0
endfunction

command! -nargs=? Scriptnames call <sid>Scratch('scriptnames', <f-args>)
command! -nargs=+ Scratch call <sid>Scratch(<f-args>)
]])
