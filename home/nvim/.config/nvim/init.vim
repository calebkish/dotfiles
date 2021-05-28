call plug#begin(stdpath('data') . '/plugged')
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'gruvbox-community/gruvbox'
Plug 'tpope/vim-fugitive'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'mbbill/undotree'

Plug 'terrortylor/nvim-comment'
Plug 'kevinhwang91/nvim-bqf'

" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

" Python
Plug 'psf/black'

" HTML
Plug 'windwp/nvim-ts-autotag'
Plug 'mattn/emmet-vim'

" Plug 'tpope/vim-sleuth'
Plug 'roryokane/detectindent'
call plug#end()



" === AUTOCOMMANDS ===

" Don't insert comment leader automatically.
autocmd FileType * setlocal formatoptions-=t formatoptions-=r formatoptions-=o

" Return to last position in exited file.
autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
    \ |   exe "normal! g`\""
    \ | endif



" === COMMANDS ===
command! -range JSONFormat <line1>,<line2>!python -m json.tool



let mapleader=" "

filetype plugin indent on
set shiftwidth=0 " Number of spaces to use for each step of (auto)indent. 
                 " Used for 'cindent', >>, <<, etc. When zero the 'tabstop'
                 " value will be used.
set smarttab " <Tab> in front of a line inserts blanks according to 
             " 'shiftwidth'. <BS> will delete a 'shiftwidth' worth of space at
             " the start of the line. 'tabstop' will be used in other places.
set tabstop=4 " Number of spaces that <Tab> counts for. Essentially, "    " 
              " will be equivalent to "\t".
set softtabstop=-1 " Number of spaces that <Tab> counts for while performing 
                   " editing operations. When negative, the value of
                   " 'shiftwidth' is used. Useful to keep 'ts' at its standard
                   " value while being able to edit like it is set to 'sts'.
set expandtab " Expand tabs to spaces.
set nosmartindent " Do smart indenting when starting a new line. Cases: After a 
                " line ending in '{', after a line starting with a keyword from
                " 'cinwords', before a line starting with '}' (only with the
                " "O" command).
set autoindent " Copy indent from current line when starting a new line. 
               " 'autoindent' is deferred when 'smartindent' applies.
set shiftround " Will remove extraneous whitespace before tabs and round to 
               " multiple of 'shiftwidth'.
set encoding=utf-8
set scrolloff=1000
set nohlsearch
set ignorecase
set smartcase " will be case insensitive unless search contains a captial letter
set noerrorbells
set number
set clipboard+=unnamedplus
set matchpairs+=<:>
set nowrap
set sidescroll=1
set sidescrolloff=5
set listchars+=tab:>-,precedes:<,extends:>
set list " shows list chars (above this line)
set hidden
set mouse=a
set guicursor=n-v-c-sm:block,i-ci-ve:ver25-Cursor,r-cr-o:hor20
set relativenumber
set nu
set noswapfile
set nobackup
set undofile
set exrc " use vim configuration in current working directory.
set nojoinspaces " Look this one up if you really care.
set nofoldenable " Disable automatic folding.
set formatoptions-=tro
set formatoptions+=c
set textwidth=80

set wildmode=longest,list,full
set wildmenu
" Ignore files
set wildignore+=**/venv/*

" Where `gf` and `:find` look for files.
set path-=/usr/include
" Where commands will stop searching upward.
set path+=;/home/caleb



" === MAPS ===
" Use current init.vim version
nmap <leader>r :so ~/.config/nvim/init.vim<CR>

" Check file in shellcheck
nmap <leader>s :!clear && shellcheck %<CR>

" Start a search on selected word.
nnoremap <leader>bs /<C-R>=escape(expand("<cWORD>"), "/")<CR><CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>pv :Ex<CR>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
" Replace selection with what's in clipboard.
vnoremap <leader>p "_dP
" Yank the entire file into clipboard.
nnoremap <leader>Y ggyG
nnoremap <leader>d "_d
vnoremap <leader>d "_d
" x and X no longer is put in + register
nnoremap x "_x
nnoremap X "_X
" Prevent indent from being removed when typing '#' as the first character in a
" new line.
inoremap # X#

" Go to a replace the next marker.
nnoremap <leader>g /<++><CR>cgn
inoremap <C-f> <++>



" === NETRW ===
let g:netrw_browse_split=0
let g:netrw_banner=0
let g:netrw_winsize=25
let g:netrw_localrmdir='rm -r'
let g:netrw_preview=1
let g:netrw_keepdir=0 " Current directory is the one you've navigated to.
let g:netrw_fastbrowse=0 " Makes netrw buffers close themselves.

nnoremap <leader>e :Lexplore<CR>

augroup netrw_maps
    autocmd!
    autocmd filetype netrw call ApplyNetrwMaps()
augroup END

function ApplyNetrwMaps()
    nmap <buffer> <leader>r mfR
    nmap <buffer> <leader>f %
    nmap <buffer> <leader>d d
    nnoremap <buffer><silent> <leader>e :call <SID>CloseNetrw()<CR>
    nnoremap <buffer><silent> <Esc> :call <SID>CloseNetrw()<CR>
    nnoremap <buffer><silent> <C-c> :call <SID>CloseNetrw()<CR>
    nmap <buffer> <C-l> :wincmd l<CR>
    nmap <buffer> p <CR><C-h>
endfunction

" Close netrw buffer after closing it.
function! s:CloseNetrw() abort
    for bufn in range(1, bufnr('$'))
        if bufexists(bufn) && getbufvar(bufn, '&filetype') ==# 'netrw'
            silent! execute 'bwipeout ' . bufn
            if getline(2) =~# '^" Netrw '
                silent! bwipeout
            endif
            return
        endif
    endfor
endfunction



" === THEMING ===
syntax on
set termguicolors
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_invert_selection='0'
colorscheme gruvbox
" Makes the background transparent
hi Normal guibg=NONE ctermbg=NONE
set colorcolumn=80
set signcolumn=yes



" === WINDOW SPLITTING ===
set splitbelow splitright
noremap <C-h> :wincmd h<CR>
noremap <C-j> :wincmd j<CR>
noremap <C-k> :wincmd k<CR>
noremap <C-l> :wincmd l<CR>



" === TABBING ===
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<CR>



" === INTEGRATED TERMINAL ===
" Use to open terminal.
"function! OpenTerminal()
"    split term://zsh
"    resize 10
"endfunction
"let $TERMCWD = expand('%:p:h')
"nnoremap <leader>t :call OpenTerminal()<CR>cd $TERMCWD<CR>clear<CR>
"
"" Exit out of terminal.
"tnoremap <C-q> <C-\><C-n>:q!<CR>
"
"" Start terminal in insert mode.
"autocmd TermOpen * startinsert
"
"" Easily navigate between terminal and other panes.
"tnoremap <C-h> <C-\><C-n><C-w>h
"tnoremap <C-j> <C-\><C-n><C-w>j
"tnoremap <C-k> <C-\><C-n><C-w>k
"tnoremap <C-l> <C-\><C-n><C-w>l
