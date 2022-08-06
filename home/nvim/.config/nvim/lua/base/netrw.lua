-- local lib = require('lib.lib')

-- netrw will open a file in the same window
vim.g.netrw_browse_split = 0

-- hide the banner
vim.g.netrw_banner = 0

-- Size of splitted windows created from netrw
vim.g.netrw_winsize = 25

vim.g.netrw_localrmdir = 'rm -r'

-- preview window shown in a vertically split window
vim.g.netrw_preview = 1

-- Makes netrw buffers close themselves
vim.g.netrw_fastbrowse = 0

local netrw_buf_defaults = 'nomodifiable nomodified nonumber nowrap readonly nobuflisted'
vim.g.netrw_bufsettings = netrw_buf_defaults .. ' signcolumn=no'

-- lib.map('n', '<Localleader>e', ':Explore<CR>')

vim.cmd([[
    function! ApplyNetrwMaps()
        nmap <buffer><silent> l <CR>
        nmap <buffer><silent> h gg<CR>

        nmap <buffer><nowait><silent> q :Rexplore<CR>
        nmap <buffer><nowait><silent> <Esc> :Rexplore<CR>
        nmap <buffer><nowait><silent> <C-c> :Rexplore<CR>
    endfunction

    augroup netrw_maps
        autocmd!
        autocmd filetype netrw call ApplyNetrwMaps()
    augroup END
]])

