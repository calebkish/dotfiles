local lib = require('lib.lib')

-- === NETRW ===
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.g.netrw_localrmdir = 'rm -r'
vim.g.netrw_preview = 1
vim.g.netrw_fastbrowse = 0 -- Makes netrw buffers close themselves.
vim.g.netrw_bufsettings = 'nonu signcolumn=no'

lib.map('n', '<Localleader>e', ':Explore<CR>')

-- Doesn't really work
-- lib.map('n', '<Localleader>e', ':let @# = "<C-r>%"<CR>:Explore<CR>/<C-r>#<CR>')

vim.cmd([[
    function! ApplyNetrwMaps()
        " Rename a file
        nmap <buffer> <leader>r mfR
        " Create a new file
        nmap <buffer> <leader>n %
        " Create a new directory
        nmap <buffer> <leader>N d
        " Delete a file
        nmap <buffer> <leader>d D

        nmap <buffer> l <CR>
        nmap <buffer> h gg<CR>

        nmap <buffer><nowait><silent> q :Rexplore<CR>
        nnoremap <buffer><silent> <Esc> :Rexplore<CR>
        nnoremap <buffer><silent> <C-c> :Rexplore<CR>
    endfunction

    augroup netrw_maps
        autocmd!
        autocmd filetype netrw call ApplyNetrwMaps()
    augroup END
]])

