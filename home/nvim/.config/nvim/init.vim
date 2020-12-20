call plug#begin(stdpath('data') . '/plugged')
Plug 'morhetz/gruvbox'
"Plug 'vimwiki/vimwiki'
Plug 'lervag/vimtex'
Plug 'unblevable/quick-scope'
call plug#end()

let mapleader =","

" Basics
	set scrolloff=1000
	set tabstop=4
	set shiftwidth=4
	set nohlsearch
	set smartcase " will be case insensitive unless search contains a captial letter
	syntax on
	set encoding=utf-8
	set number
	set clipboard+=unnamedplus
	set matchpairs+=<:>
	set nowrap
	set sidescroll=1
	set sidescrolloff=5
	set listchars=tab:\ \ ,precedes:<,extends:>
	set list " shows list chars (above this line)
	set shiftround " will remove extraneous whitespace before tabs and round to multiple of shiftwidth

" Colorscheme
	set termguicolors
	set background=dark
	let g:gruvbox_contrast_dark = 'hard'
	let g:gruvbox_transparent_bg = 1
	colorscheme gruvbox

" Folding
	set foldmethod=manual
	" If on line of something foldable, fold it with Space. Otherwise, do normal Space behavior.
	nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
	" Create a fold in visual mode with Space.
	vnoremap <Space> zf
	" Set foldmethod=manual if in file that doesn't have syntax highlighting
	augroup vimrc
		au BufReadPre * setlocal foldmethod=indent
		au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
	augroup END

" Window splitting
	set splitbelow splitright
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l

" Replace all is aliased to S.
	nnoremap S :%s//g<Left><Left>

" Disables automatic commenting on newline:
	autocmd BufEnter * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Use current init.vim version
	nmap <leader>r :so ~/.config/nvim/init.vim<CR>

" Check file in shellcheck:
	nmap <leader>s :!clear && shellcheck %<CR>

" vimwiki
"	let g:vimwiki_list = [{
"		\ 'path': '~/vimwiki/',
"		\ 'syntax': 'markdown',
"		\ 'ext': '.md',
"		\ 'template_path': '~vimwiki/templates/',
"		\ 'template_default': 'default',
"		\ 'path_html': '~/vimwiki/site_html/',
"		\ 'custom_wiki2html': 'vimwiki_markdown',
"		\ 'template_ext': '.tpl'}]

" latex
	let g:vimtex_view_method = 'zathura'
	let g:tex_flavor = 'latex'

" quick-scope
	nmap <leader>q <plug>(QuickScopeToggle)
	xmap <leader>q <plug>(QuickScopeToggle)
	let g:qs_buftype_blacklist = ['terminal', 'nofile']
	let g:qs_delay = 0
