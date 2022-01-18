call plug#begin(stdpath('data') . '/plugged')
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'gruvbox-community/gruvbox'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'terrortylor/nvim-comment'

" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'ThePrimeagen/harpoon'

Plug 'windwp/nvim-ts-autotag'

Plug 'psliwka/vim-smoothie'
Plug 'windwp/nvim-autopairs'

Plug 'puremourning/vimspector'

Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax' 
call plug#end()



" === AUTOCOMMANDS ===

" Don't insert comment leader automatically.
autocmd FileType * setlocal formatoptions-=t formatoptions-=r formatoptions-=o

" Return to last position in exited file.
autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
    \ |   exe "normal! g`\""
    \ | endif

autocmd Filetype html,css,scss,typescript,javascript,json setlocal tabstop=2



" === COMMANDS ===
command! -range JSONFormat <line1>,<line2>!python -m json.tool



let mapleader=" "
let maplocalleader="\\"

filetype plugin indent on
set shiftwidth=0 " Number of spaces to use for each step of (auto)indent. 
                 " Used for 'cindent', >>, <<, etc. When zero the 'tabstop'
                 " value will be used.
set tabstop=4 " Number of spaces that <Tab> counts for. Essentially, "    " 
              " will be equivalent to "\t".
set softtabstop=-1 " Number of spaces that <Tab> counts for while performing 
                   " editing operations. When negative, the value of
                   " 'shiftwidth' is used. Useful to keep 'ts' at its standard
                   " value while being able to edit like it is set to 'sts'.
set expandtab " Expand tabs to spaces.
set smarttab " <Tab> in front of a line inserts blanks according to 
             " 'shiftwidth'. <BS> will delete a 'shiftwidth' worth of space at
             " the start of the line. 'tabstop' will be used in other places.
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



" === THEMING ===
syntax on
set colorcolumn=80
set signcolumn=yes
set termguicolors
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_invert_selection='0'
colorscheme gruvbox
" Makes backgrounds transparent
highlight Normal guibg=NONE ctermbg=NONE
highlight SignColumn guibg=NONE ctermbg=NONE



" === MAPS ===
noremap <ScrollWheelUp> <C-Y>
noremap <ScrollWheelDown> <C-E>
nnoremap <leader>d "_d
vnoremap <leader>d "_d

" Use current init.vim version
nmap <leader>r :so ~/.config/nvim/init.vim<CR>
" Check file in shellcheck
nmap <leader>s :!clear && shellcheck %<CR>
" x and X no longer is put in + register
nnoremap x "_x
nnoremap X "_X
" Prevent indent from being removed when typing '#' as the first character in a new line.
inoremap # X#
" Copy to end of line
nnoremap Y y$

noremap <F15> <nop>


" Keep things centered
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z
nnoremap <C-j> :cnext<CR>zzzv
nnoremap <C-k> :cprev<CR>zzzv

" Undo breakpoints
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u

" Jumplist mutations
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

" Moving lines around
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
nnoremap <leader>j :m .+1<CR>==
nnoremap <leader>k :m .-2<CR>==



" === NETRW ===
let g:netrw_browse_split=0
let g:netrw_banner=0
let g:netrw_winsize=25
let g:netrw_localrmdir='rm -r'
let g:netrw_preview=1
let g:netrw_fastbrowse=0 " Makes netrw buffers close themselves.
let g:netrw_bufsettings='nonu relativenumber signcolumn=no'

nnoremap <silent><localleader>e :Explore<CR>

augroup netrw_maps
    " Remove all group autocommands
    autocmd!
    autocmd filetype netrw call ApplyNetrwMaps()
augroup END

function ApplyNetrwMaps()
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

    nnoremap <buffer><silent> <Esc> :Rexplore<CR>
    nnoremap <buffer><silent> <C-c> :Rexplore<CR>
endfunction



" === WINDOW SPLITTING ===
set splitbelow splitright
noremap <silent><C-h> :wincmd h<CR>
noremap <silent><C-j> :wincmd j<CR>
noremap <silent><C-k> :wincmd k<CR>
noremap <silent><C-l> :wincmd l<CR>



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

